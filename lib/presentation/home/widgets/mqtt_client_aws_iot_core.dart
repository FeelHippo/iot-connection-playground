import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:url_launcher/url_launcher.dart';

class MqttClientAwsIotCoreWidget extends StatelessWidget {
  const MqttClientAwsIotCoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          child: const Text(
            'AWS IoT Core MQTT broker and publisher',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () => launchUrl(
            Uri.parse(
              'https://github.com/shamblett/mqtt5_client/blob/master/example/aws_iot_certificates.dart',
            ),
          ),
        ),
        FloatingActionButton(
          key: const Key('mqtt_client_aws_iot_core'),
          heroTag: 'mqtt_client_aws_iot_core',
          child: const Icon(Icons.add),
          onPressed: () => _connectToASWIoTCore(context),
        ),
      ],
    );
  }

  // https://github.com/shamblett/mqtt5_client/blob/master/example/aws_iot_certificates.dart
  Future<void> _connectToASWIoTCore(BuildContext buildContext) async {
    // Your AWS IoT Core endpoint url
    const String url = 'a2eqw4se8i5px2-ats.iot.eu-west-1.amazonaws.com';
    // AWS IoT MQTT default port
    const int port = 8883;
    // The client id unique to your device
    // defaults to AWS IoT Device "name"
    // const String clientId = 'smartThing';
    // MQTT test client:
    const String clientId = 'iotconsole-4cc4a684-a14b-473f-a4dc-99911ef994a8';

    // Create the client
    final MqttServerClient client =
        MqttServerClient.withPort(url, clientId, port)
          // Set secure
          ..secure = true
          // Set Keep-Alive
          ..keepAlivePeriod = 20
          // logging if you wish
          ..logging(on: true);

    // Set the security context as you need, note this is the standard Dart SecurityContext class.
    // If this is incorrect the TLS handshake will abort and a Handshake exception will be raised,
    // no connect ack message will be received and the broker will disconnect.
    // For AWS IoT Core, we need to set the AWS Root CA, device cert & device private key
    // Note that for Flutter users the parameters above can be set in byte format rather than file paths

    // https://github.com/flutter/flutter/issues/39190
    // to convert certificate file into base64:
    // cat smartThing.private.key | base64 -w0

    // https://docs.aws.amazon.com/iot/latest/developerguide/diagnosing-connectivity-issues.html
    // to verify certs allow to establish a connection to AWS
    // openssl s_client -connect a2eqw4se8i5px2-ats.iot.eu-west-1.amazonaws.com:8443 -CAfile root-CA.crt -cert c145d9c1c7e799778bebbada415dadbd22f16a36b66c333e5a9baa186d0f4414-certificate.pem.crt -key smartThing.private.key
    // (from where the cert files are stored). Example response
    // SSL handshake has read 5609 bytes and written 2823 bytes
    // Verification: OK
    // ---
    //     New, TLSv1.3, Cipher is TLS_AES_128_GCM_SHA256
    // Protocol: TLSv1.3
    // Server public key is 2048 bit
    // This TLS version forbids renegotiation.
    // Compression: NONE
    // Expansion: NONE
    // No ALPN negotiated
    // Early data was not sent
    // Verify return code: 0 (ok)
    // ---

    // https://stackoverflow.com/a/59542026
    // the Root Certificate Authority is publicly shared by AWS:
    const String rootCARaw =
        'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURRVENDQWltZ0F3SUJBZ0lUQm15Zno1bS9qQW81NHZCNGlrUG1salpieWpBTkJna3Foa2lHOXcwQkFRc0YKQURBNU1Rc3dDUVlEVlFRR0V3SlZVekVQTUEwR0ExVUVDaE1HUVcxaGVtOXVNUmt3RndZRFZRUURFeEJCYldGNgpiMjRnVW05dmRDQkRRU0F4TUI0WERURTFNRFV5TmpBd01EQXdNRm9YRFRNNE1ERXhOekF3TURBd01Gb3dPVEVMCk1Ba0dBMVVFQmhNQ1ZWTXhEekFOQmdOVkJBb1RCa0Z0WVhwdmJqRVpNQmNHQTFVRUF4TVFRVzFoZW05dUlGSnYKYjNRZ1EwRWdNVENDQVNJd0RRWUpLb1pJaHZjTkFRRUJCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFMSjRnSEhLZU5YagpjYTlIZ0ZCMGZXN1kxNGgyOUpsbzkxZ2hZUGwwaEFFdnJBSXRodE9nUTNwT3NxVFFOcm9Cdm8zYlNNZ0hGelpNCjlPNklJOGMrNnpmMXRSbjRTV2l3M3RlNWRqZ2RZWjZrL29JMnBlVktWdVJGNGZuOXRCYjZkTnFjbXpVNUwvcXcKSUZBR2JIclFnTEttK2Evc1J4bVBVRGdIM0tLSE9WajR1dFdwK1Vobk1KYnVsSGhlYjRtalVjQXdobWFoUldhNgpWT3VqdzVINVNOei8wZWd3TFgwdGRIQTExNGdrOTU3RVdXNjdjNGNYOGpKR0tMaEQrcmNkcXNxMDhwOGtEaTFMCjkzRmNYbW4vNnBVQ3l6aUtybEE0Yjl2N0xXSWJ4Y2NlVk9GMzRHZklENXlISTlZL1FDQi9JSURFZ0V3K095UW0KamdTdWJKcklxZzBDQXdFQUFhTkNNRUF3RHdZRFZSMFRBUUgvQkFVd0F3RUIvekFPQmdOVkhROEJBZjhFQkFNQwpBWVl3SFFZRFZSME9CQllFRklRWXpJVTA3THdNbEpRdUNGbWN4N0lRVGdvSU1BMEdDU3FHU0liM0RRRUJDd1VBCkE0SUJBUUNZOGpkYVFaQ2hHc1YyVVNnZ05pTU9ydVlvdTZyNGxLNUlwREIvRy93a2pVdTB5S0dYOXJieGVuREkKVTVQTUNDamptQ1hQSTZUNTNpSFRmSVVKclU2YWRUckNDMnFKZUhaRVJ4aGxiSTFCamp0L21zdjB0YWRRMXdVcwpOK2dEUzYzcFlhQUNidlh5OE1XeTdWdTMzUHFVWEhlZUU2Vi9VcTJWOHZpVE85NkxYRnZLV2xKYllLOFU5MHZ2Cm8vdWZRSlZ0TVZUOFF0UEhSaDhqcmRrUFNIQ2EyWFY0Y2RGeVF6UjFibGRad2dKY0ptQXB6eU1aRm82SVE2WFUKNU1zSSt5TVJRK2hES1hKaW9hbGRYZ2pVa0s2NDJNNFV3dEJWOG9iMnhKTkRkMlpod0xub1FkZVhlR0FEYmtweQpycVhSZmJvUW5vWnNHNHE1V1RQNDY4U1F2dkc1Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K';

    // this is related to the AWS IoT Certificate
    // available at AWS IoT > Security > Certificates
    // the file name is e.g. c145d9c1c7e799778bebbada415dadbd22f16a36b66c333e5a9baa186d0f4414-certificate.pem.crt
    // where is the Certificate ID
    const String devicePemRaw =
        'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURXVENDQWtHZ0F3SUJBZ0lVV0FxN3J5Y3pNTE80TnYzR3E3MGl3UitPSDBJd0RRWUpLb1pJaHZjTkFRRUwKQlFBd1RURkxNRWtHQTFVRUN3eENRVzFoZW05dUlGZGxZaUJUWlhKMmFXTmxjeUJQUFVGdFlYcHZiaTVqYjIwZwpTVzVqTGlCTVBWTmxZWFIwYkdVZ1UxUTlWMkZ6YUdsdVozUnZiaUJEUFZWVE1CNFhEVEkyTURFd05URTJNRFV3Ck5Wb1hEVFE1TVRJek1USXpOVGsxT1Zvd0hqRWNNQm9HQTFVRUF3d1RRVmRUSUVsdlZDQkRaWEowYVdacFkyRjAKWlRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT1Z1T3JGMHVWUTNsVTZOblRDegpEMnBLaE5xOG53ZWVtcUoxcFNKTVNuUzlsYUtMcG9UcXdIaG0yTUVZaGg1L3pDRGVsOGVvTTRoS1JzY0xOZjVJCnBzbkhQeEZ1RzlRR3JVSHFSdUlKcDcrRDhxdVorNS95cEZlY1RiSVExd2VTeG5hRnpKblV2SnFETFFnUWhUcXQKSHBSYjJiT2ZGUUNxaTU4T0l2VlEyWGtzY0lrZzVEdmFIZnhsOXZhM3d0ci9KQ3dWY3ZCVlFLZUdRR1o2UjRvcwp3bDlSTGtSVjlTSjJ0OXFBNkowQkxxdGtBVDROYUc5RlB4Y3ByUWJnWTJJMHVMWWVPT2tPWlkrMzBTZWdWMUNzCmJhNWZCWWxLdnpIZ2RkTWEvSWEzbWgyZGhQaktVN1FIdlFDMHBEMGR5V3FVdllZYU1DemQxcDNUcnBCWnZoL0cKNU1zQ0F3RUFBYU5nTUY0d0h3WURWUjBqQkJnd0ZvQVVsYWFwbm1UMWl1anlSUEQzd2lsK3EzbW1BdFF3SFFZRApWUjBPQkJZRUZQcjR5TjhtSFR5SnlJcmY3cjAybm9sUGZnUURNQXdHQTFVZEV3RUIvd1FDTUFBd0RnWURWUjBQCkFRSC9CQVFEQWdlQU1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQjkxMVZIU3hEVGZyTkl0RkFzMFhHUHdvZS8KRnNnelRocUhTVHhHTDhNNDN6bGZERWxpWHN5M2QwRlR1K0pESktGSmJnRlNMYTBoWEZzSXVWbTY0SGtUVkVRSQphV2IzWkhzRmw2N0ZhL09nUkNhaHdSZWprc3d5RW4ybTdlRlBLTlJOSWFFd1FrK1J2czdVWVR6SndHekY0aGJaCnBHOHNDREltZWRSRTZQMXFYZ0FWVnQrSG1RbmFjdEZVT1llQmU3eU1Wd2tXb3JSTFQxdGEyb3Z0NlpkajljeVAKak1vU0NIbk4zaE5Mc0d6YUgwRUdyWWUyMitNKzgwSENnTzBrSm5LUGxxNlZ6VjNDaHJteUYwbDFyZldHclNEcQozT2x2TStoWXZ3VUNlRENQUTlGSXlEOEY3R2QxUkY2dFZCaThPZWwyRkZVa2I0dDJHSFZQZDAvWkJNaUUKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=';

    const String privatePemRaw =
        'LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb2dJQkFBS0NBUUVBNVc0NnNYUzVWRGVWVG8yZE1MTVBha3FFMnJ5ZkI1NmFvbldsSWt4S2RMMlZvb3VtCmhPckFlR2JZd1JpR0huL01JTjZYeDZnemlFcEd4d3MxL2tpbXljYy9FVzRiMUFhdFFlcEc0Z21udjRQeXE1bjcKbi9La1Y1eE5zaERYQjVMR2RvWE1tZFM4bW9NdENCQ0ZPcTBlbEZ2WnM1OFZBS3FMbnc0aTlWRFplU3h3aVNEawpPOW9kL0dYMjlyZkMydjhrTEJWeThGVkFwNFpBWm5wSGlpekNYMUV1UkZYMUluYTMyb0RvblFFdXEyUUJQZzFvCmIwVS9GeW10QnVCallqUzR0aDQ0NlE1bGo3ZlJKNkJYVUt4dHJsOEZpVXEvTWVCMTB4cjhocmVhSFoyRStNcFQKdEFlOUFMU2tQUjNKYXBTOWhob3dMTjNXbmRPdWtGbStIOGJreXdJREFRQUJBb0lCQUd2VDE0L3BUT1RRenNKQgplandXRzh1WHhFTE5YV3lHVlNTL1orSHJ1eDZNcjVQYVVHT3R0TkdoZklPY0ZBU25pWGQxUmg1VzVnbEs1MkxLCjJSQnVjcnpvZ0xLZmJrTEM5SkRERzVkR2RHbGxDUnN2WG53NDNKWTBacXVta0hrRnVYS2d4WjBTeDZWU3UwcE0KQVdHblZYVGlpam1LTGFQSGc2RTRVcU82NE1xNmZSTG9ZMVliU0lWbjYrMWdZRUplbVRmanlTUXR4MU5Vb0VGaApXYzkrdWd6VDU3bTZlZnBpOElUT1EzNGdObXI1d1BlNzgrdEh1UHhGRnI0SzhEWkhIRlhtSmd4MGxNV2VGK3JiCm5oaWVZUDdzeEJ1YUg0K29MMkFoTFQxc1hVZ0prZldPZGlqTTlJQzNRTkNVeEFidTQ3QTZBdS9wVllDNWxXaVAKcDZBOGtCRUNnWUVBL09JMjlVaWpNVmovQmdhN004MEQvZjNQOW9MOWladW5GT3dVcVRFOU5JbUlscXFxNWswawpyR2VOcTg0V0VCMVpWRHJLak11dHdmQVpwekxrWUFMT0k2REtxcVp4ODUxVFU4a29nRytjSkR0QndWYnFJSTFNClJlM1ZFWmJsVk1OTVdRU0hVbURMNHEwZ2RITGhVYnQ3Vkhnay9HZkplaHpVcWVCd1Bsc1FVOGtDZ1lFQTZFSUcKcGJiTEw4RnRkbjI4TzBDd3NNbEZZdFFINTVOcUxvZENDMGxVcks2MlFzc3BPQ3JIZUI5NDJYTkptVnJBSVpXcQozclE1MDBhTHJoRVRkU00zRFhVZXFZcWtGTmMzSHg0eEJLWHVwMS9kOTJOT0NMVHIxS3EyN3UzNndoN1hnRGo2CkgrenoyVGNxQlVEbTNQZ3NoNTk2QkcvY1BUeGdXaXM4aFRKWTlmTUNnWUFCdVkxRWFRVnI3YjUzalE0ejBUOG8KdVZWMHlmbnV1VmdQWlhqU21wcGZSRnpoSWpMZU5VSjl4b3NKMC9NRWt4NnIyMmJNUlF0ZldrTGlpQTlVdEZBeApvQVFoMjliRklacVM1TGxZL3VuaXVXQytiOWhTOW9QQnFsaWNzUm5KVlRldEY4SFFod1o4K2s5UlhBTTdhbnJ4CjNZdnJDTTR2L2doWlRFV1h0MGxLT1FLQmdETXlDcUVRaiswdzU5NE1qU2RLZFNnaTFZYVpVank3ZzlaSnZrY2EKbk8yTGZXVnZ2dUJBbmNOZXZKYkNFT0VhM2VzSlFLYmlkelNaQWtVV1FvRzVoM01SOC9aUE55Zlk0SytkU2hUSwpOcmJ5TE0xUk9HdzI1UnoxbkdsQ1Q5bm1UbjVYRU50a3NjT1pvMHVSS05KZ2FnQmpLTlE5akFCN2hJbWJxalY2CkNaMzlBb0dBRVEvQUxjUnFpMGIyb2srOTJWYjVJL2R0SEhBR1RicXhOTUZPb2hnVGU3WFEvODRhbS93ZkJWNE0KUlZHSFZYNEFpVGVJNXlIQkQ0RzFxMnN5ck1sS29XRHI1UVNJdUpyckV6VFdOWGZqSGtZUGpQRTJJSldoZ1ZJZgpMRFJWQnF1R3VkMUszbERvdW9md1FTYWpoTXdNVTdtUHVqeTJORklma2VzbHFTYlVqMFk9Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==';

    // https://medium.com/@alisusanto.main/rsa-encryption-with-flutter-d3cf6e47b833
    // https://pub.dev/documentation/basic_utils/latest/basic_utils/CryptoUtils/getBytesFromPEMString.html
    final Uint8List rootCA = CryptoUtils.getBytesFromPEMString(
      rootCARaw,
      checkHeader: false,
    );
    final Uint8List devicePem = CryptoUtils.getBytesFromPEMString(
      devicePemRaw,
      checkHeader: false,
    );
    final Uint8List privatePem = CryptoUtils.getBytesFromPEMString(
      privatePemRaw,
      checkHeader: false,
    );

    final SecurityContext context = SecurityContext.defaultContext
      ..setClientAuthoritiesBytes(rootCA)
      ..useCertificateChainBytes(devicePem)
      ..usePrivateKeyBytes(privatePem);
    client.securityContext = context;

    // Setup the connection Message
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean();
    client.connectionMessage = connMess;

    // Connect the client
    try {
      await client.connect();
    } on Exception catch (e) {
      client.disconnect();
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(buildContext).colorScheme.error,
          content: Text(e.toString(), textAlign: TextAlign.center),
        ),
      );
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(buildContext).colorScheme.secondary,
          content: const Text(
            'MQTT client connected to AWS IoT',
            textAlign: TextAlign.center,
          ),
        ),
      );

      // Publish to a topic of your choice after a slight delay, AWS seems to need this
      await MqttUtilities.asyncSleep(1);
      // make sure the topic is whitelisted by the AWS IoT Cert Policy
      // https://eu-west-1.console.aws.amazon.com/iot/home?region=eu-west-1#/policy/smartThing-Policy
      const String topic = 'sdk/test/dart';
      final MqttPayloadBuilder builder = MqttPayloadBuilder()
        ..addString('{ "message": "Hello World" }');

      // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!
      client
        ..publishMessage(topic, MqttQos.atLeastOnce, builder.payload!)
        ..subscribe(
          topic,
          MqttQos.atLeastOnce,
        ); // TODO(Filippo): blocker is here https://github.com/shamblett/mqtt_client/issues/640

      // Print incoming messages from another client on this topic
      client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String pt = MqttPublishPayload.bytesToString(
          recMess.payload.message,
        );
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(buildContext).colorScheme.secondary,
            content: Text(pt, textAlign: TextAlign.center),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(buildContext).colorScheme.error,
          content: Text(
            'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}',
            textAlign: TextAlign.center,
          ),
        ),
      );
      client.disconnect();
    }

    await MqttUtilities.asyncSleep(10);

    // client.disconnect();
  }
}
