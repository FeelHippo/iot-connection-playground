import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:url_launcher/url_launcher.dart';

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
  // Generate a presigned request with the WebSocket library
  // https://docs.aws.amazon.com/iot-wireless/latest/developerguide/network-analyzer-generate-request.html
  // Policies for HTTP and WebSocket clients
  // https://docs.aws.amazon.com/iot/latest/developerguide/pub-sub-policy.html#pub-sub-policy-cognito
  // AWS IoT Core Simplified
  // https://dev.to/slootjes/aws-iot-core-simplified-part-1-permissions-k4d

  // BLOCKER: https://repost.aws/questions/QUrwQ2-a0pTYGDRtNNWtx0qw/mqtt-over-websocket-signature-version-4-http-1-1-403
  // https://repost.aws/questions/QU-zwByDFvRve57kJEeIu0BQ/generate-a-presigned-url-with-aws-iot-device-sdk-embedded-c
  // https://repost.aws/questions/QUy0UvJxbHQ2CnooSaimpaXw/iot-credentials-for-aws-403-debug
  // https://docs.aws.amazon.com/iot/latest/developerguide/authorizing-direct-aws.html
  // https://aws.amazon.com/blogs/security/how-to-eliminate-the-need-for-hardcoded-aws-credentials-in-devices-by-using-the-aws-iot-credentials-provider/

  // useful commands:
  // returns the credential provider's address
  // aws iot describe-endpoint --endpoint-type iot:CredentialProvider
  // returns the IoT Role Alias => check if the IAM role is used
  // aws iot describe-role-alias --role-alias smartThingAdminRoleAlias
  // reutrns the IAM Role
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
    const String region = 'eu-west-1';
    const String endpoint = 'a2eqw4se8i5px2-ats.iot.eu-west-1.amazonaws.com';
    const String credentialProvider =
        'cyltlnzsrjwaw.credentials.iot.eu-west-1.amazonaws.com';

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

    // TODO(Filippo): add proper Data Model
    final dynamic parsedBody = jsonDecode(credentials.body);
    final String accessKeyId =
        parsedBody['credentials']['accessKeyId'] as String;
    final String secretAccessKey =
        parsedBody['credentials']['secretAccessKey'] as String;
    final String sessionToken =
        parsedBody['credentials']['sessionToken'] as String;
    final AWSCredentials awsCredentials = AWSCredentials(
      accessKeyId,
      secretAccessKey,
      sessionToken,
    );

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    final AWSSigV4Signer signer = AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(awsCredentials),
    );
    // Create the signing scope and HTTP request
    final AWSCredentialScope scope = AWSCredentialScope(
      region: region,
      service: AWSService.iot,
    );
    final AWSHttpRequest request = AWSHttpRequest(
      method: AWSHttpMethod.get,
      uri: Uri(scheme: 'wss', host: endpoint, path: 'mqtt', port: 443),
    );

    const Duration expiration = Duration(seconds: 3600);

    // Sign and send the HTTP request
    final Uri signedRequest = await signer.presign(
      request,
      credentialScope: scope,
      expiresIn: expiration,
    );
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // The client id unique to your device
    // defaults to AWS IoT Device "name"
    const String clientId = 'smartThing-mezzasegolas@gmail.com';

    // Create the client
    final MqttServerClient client =
        MqttServerClient(signedRequest.toString(), clientId)
          ..useWebSocket = true
          ..useAlternateWebSocketImplementation = true
          ..port = 443
          ..logging(on: true)
          ..keepAlivePeriod = 20;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    /// Add some user properties, these may be available in the connect acknowledgement.
    /// Note there are many options selectable on this message, if you opt to use authentication please see
    /// the example in mqtt5_server_client_authenticate.dart.
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean();
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect();
    } on MqttNoConnectionException catch (e) {
      // Raised by the client when connection fails.
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      client.disconnect();
    }

    if (client.connectionStatus!.state != MqttConnectionState.connected) {
      client.disconnect();
      return;
    }

    const String topic = 'sdk/test/dart'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload! as MqttPublishMessage;
      final String pt = MqttUtilities.bytesToStringAsString(
        recMess.payload.message!,
      );
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(buildContext).colorScheme.secondary,
          content: Text(pt, textAlign: TextAlign.center),
        ),
      );
    });

    final MqttPayloadBuilder builder = MqttPayloadBuilder()
      ..addString('{ "message": "Hello World" }');

    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);

    await MqttUtilities.asyncSleep(120);

    // client.unsubscribeStringTopic(topic);
    // client.disconnect();
  }
}
