import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:giggle/presentation/home/models/credentials.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MqttClientAwsWebSocketWidget extends StatelessWidget {
  const MqttClientAwsWebSocketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          child: const Text(
            'AWS IoT Core MQTT over WSS',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () => launchUrl(
            Uri.parse(
              'https://github.com/shamblett/mqtt5_client/blob/master/example/mqtt5_server_client_websocket_secure.dart',
            ),
          ),
        ),
        FloatingActionButton(
          mini: true,
          key: const Key('mqtt_client_aws_iot_core'),
          heroTag: 'mqtt_client_aws_websocket',
          child: const Icon(Icons.add),
          onPressed: () => _connectToASWWebSocket(context),
        ),
      ],
    );
  }

  // https://github.com/shamblett/mqtt5_client/blob/master/example/mqtt5_server_client_websocket_secure.dart
  // https://docs.aws.amazon.com/iot/latest/developerguide/protocols.html

  // Authentication:
  // Authenticating Requests: Using Query Parameters (AWS Signature Version 4)
  // https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html
  // AWS IoT Core Simplified
  // https://dev.to/slootjes/aws-iot-core-simplified-part-1-permissions-k4d

  // BLOCKER: https://repost.aws/questions/QUdbcJYpBLRmmwmCss6Irtiw/mqtt-client-over-websocket-403

  // useful commands:
  // returns the credential provider's address
  // aws iot describe-endpoint --endpoint-type iot:CredentialProvider
  // returns the IoT Role Alias => check if the IAM role is used
  // aws iot describe-role-alias --role-alias smartThingAdminRoleAlias
  // returns the IAM Role
  // aws iam get-role --role-name smartThingAdminRole
  // obtain your AWS account-specific endpoint for the credentials provider
  // aws iot describe-endpoint --endpoint-type iot:CredentialProvider
  // {
  // "endpointAddress": "cyltlnzsrjwaw.credentials.iot.eu-west-1.amazonaws.com"
  // }
  // HTTPS request to the credentials provider to fetch a security token
  // curl --cert c145d9c1c7e799778bebbada415dadbd22f16a36b66c333e5a9baa186d0f4414-certificate.pem.crt --key smartThing.private.key -H "x-amzn-iot-thingname: smartThing" https://cyltlnzsrjwaw.credentials.iot.eu-west-1.amazonaws.com/role-aliases/smartThingAdminRoleAlias/credentials
  // {"credentials":{"accessKeyId":"ASIAUCCMJ5DSWNRZAZ5U","secretAccessKey":"ya/tmlo+hWsy8KkO48heMnXZMe07jqhxC/5UIMFN","sessionToken":"IQoJb3JpZ2luX2VjEH0aCWV1LXdlc3QtMSJHMEUCIQDL7xpju5RfYA92Vv1ohzvc/tIVcKftC0LdEMGNzMTlHwIgGk2R8SCo/vvI9zyqVM4a+PsdjoCYUTTWADtIWDOQv2gqvgMIRhAAGgwyNzkzMzI5MDcyMzciDLeFjfYS6xKSRXP8WCqbA+WqQGRCURSJwp0ssLYQCwZnkLIAmYDBOSWbWI/len68QdDCqIQdjm6qtCzb5fecXPuxfZwRrtuWDYakrQrMB0dS6KICWtJHeA6BMf1QrmT7s8Kd3ZAcTvx0JmDmfZM/VeSnX+1/cGMSwXqb49O7k7fjgxaXygnykFEEMF+6VVtang91xBDeaWzmQBWnZRrJGeT3DxQmeUQUbiI4yYA3zL/hM67v0yiqyw6qelFve1LSuY7L6sUMbkcqk0NfxFrolNmcQGDGSL0PMTcdCBFktnnP6j22JeNvkFW5lTYy7AmstfRJ61LM/nzD1p5oEiRTsgmAXKO+o4sRRPsKLz+rq0ohFmfY68wl56ZpBV/1g3Sity4MtciHvWDX51X+XkX8GRsgHraQgEwjOdAjae1IsY1jdgpEV08eIU8DRCyEdCGW6mOw7dmFDevfiB26ve+NtF5DdvEroFd/7kRoDxSbMxsCvPba/P1FO4ZFP13gUvDQRbD8jTIXrSvynnfRtj1slzIaUEoP1zZ7UVRZZ7Jg/MqinzQG9h6vMnVkaDDyzpfMBjqUAbMmsfpQLL/ediHUXGF/SQaEeYY+PO+X8GWpbxZ7ddVdCTkGot0Il4ASHllxcpgOTWWySgurfWRTFagzbqKphCKesRh4dwx8DRc/CNAW1THazSQNlk9ox/ITbNf/SX0QQztkPLHcfiukruxQCNSNf3pQ9DzhCiU9aFPxC8NSjiCujbU3gVU+FQ7ePzdONa9aKGNEjv0=","expiration":"2026-02-06T14:06:58Z"}}⏎

  // Web Socket Certificate
  // curl --cert 66ce483973c5f09019f455b6140666b54fac452cd1e9c0f129ab24c6488eba73-certificate.pem.crt --key device_cert_key_filename.key -H "x-amzn-iot-thingname: smartThing" https://cyltlnzsrjwaw.credentials.iot.eu-west-1.amazonaws.com/role-aliases/SmartThingRoleAlias/credentials

  Future<void> _connectToASWWebSocket(BuildContext buildContext) async {
    // The client id unique to your device
    // defaults to AWS IoT Device "name"
    const String clientId = 'smartThing-mezzasegolas@gmail.com';
    const String region = 'eu-west-1';
    const String endpoint = 'a2eqw4se8i5px2-ats.iot.eu-west-1.amazonaws.com';
    const String credentialProvider =
        'cyltlnzsrjwaw.credentials.iot.eu-west-1.amazonaws.com';

    // Credentials Provider
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    final String cert = await rootBundle.loadString(
      'assets/certificates/66ce483973c5f09019f455b6140666b54fac452cd1e9c0f129ab24c6488eba73-certificate.pem.crt',
    );
    final String key = await rootBundle.loadString(
      'assets/certificates/smartThingWebSocket.private.key',
    );
    final SecurityContext context = SecurityContext.defaultContext
      ..useCertificateChainBytes(utf8.encode(cert))
      ..usePrivateKeyBytes(utf8.encode(key));
    final HttpClient httpClient = HttpClient(context: context);
    final IOClient awsClient = IOClient(httpClient);
    final http.Response credentials = await awsClient.get(
      Uri.parse(
        'https://$credentialProvider/role-aliases/SmartThingRoleAlias/credentials',
      ),
      headers: <String, String>{'x-amzn-iot-thingname': 'smartThing'},
    );

    final Credentials credentialsBody = Credentials.fromJson(
      jsonDecode(credentials.body) as Map<String, dynamic>,
    );

    if (credentialsBody.credentials == null) return;
    final String accessKeyId = credentialsBody.credentials!.accessKeyId;
    final String secretAccessKey = credentialsBody.credentials!.secretAccessKey;
    final String sessionToken = credentialsBody.credentials!.sessionToken;
    final AWSCredentials awsCredentials = AWSCredentials(
      accessKeyId,
      secretAccessKey,
    );

    // Signature v4
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    final AWSSigV4Signer signer = AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(awsCredentials),
    );
    // Create the signing scope and HTTP request
    final AWSCredentialScope scope = AWSCredentialScope(
      dateTime: AWSDateTime.now(),
      region: region,
      service: AWSService.iot,
    );
    final AWSHttpRequest request = AWSHttpRequest(
      method: AWSHttpMethod.get,
      uri: Uri(scheme: 'wss', host: endpoint, path: 'mqtt', port: 443),
    );

    const Duration expiration = Duration(seconds: 3600);

    // Sign and send the HTTP request
    final Uri signedRequest =
        await signer.presign(
            request,
            credentialScope: scope,
            expiresIn: expiration,
          )
          ..normalizePath();

    // https://github.com/aws/aws-sdk-go/issues/2485
    final Uri server = Uri.parse(
      '$signedRequest&X-Amz-Security-Token=$sessionToken',
    );

    // MQTT client
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // Create the client
    late WebSocketChannel channel = WebSocketChannel.connect(server);

    try {
      channel = WebSocketChannel.connect(server);
      await channel.ready;
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(buildContext).colorScheme.secondary,
          content: const Text(
            'Successfully connected to WebSocket',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(buildContext).colorScheme.error,
          content: Text(e.toString(), textAlign: TextAlign.center),
        ),
      );
    }

    const String topic = 'sdk/test/dart';

    channel.stream.listen(
      (dynamic data) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(buildContext).colorScheme.secondary,
            content: const Text(
              'Successfully connected to WebSocket',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
      onError: (dynamic error) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(buildContext).colorScheme.error,
            content: Text('$error', textAlign: TextAlign.center),
          ),
        );
      },
    );
  }
}
