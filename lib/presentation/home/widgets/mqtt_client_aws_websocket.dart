import 'dart:async';
import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter/material.dart';
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
            style: TextStyle(fontSize: 24),
          ),
          onTap: () => launchUrl(
            Uri.parse(
              'https://github.com/shamblett/mqtt5_client/blob/master/example/mqtt5_server_client_websocket_secure.dart',
            ),
          ),
        ),
        FloatingActionButton(
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

  Future<void> _connectToASWWebSocket(BuildContext buildContext) async {
    const String region = 'eu-west-1';
    // Connecting to AWS IoT Core
    // MQTT over WSS: wss://iot-endpoint/mqtt
    // Your AWS IoT Core endpoint url
    const String endpoint = 'a2eqw4se8i5px2-ats.iot.eu-west-1.amazonaws.com';
    const String canonicalRequest = 'wss://$endpoint/mqtt';

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // On mobile and web, this means using the Dart environment which is configured by passing the --dart-define flag to your flutter commands, e.g.
    // $ flutter run --dart-define=AWS_ACCESS_KEY_ID=... --dart-define=AWS_SECRET_ACCESS_KEY=...
    const AWSSigV4Signer signer = AWSSigV4Signer();
    // Create the signing scope and HTTP request
    final AWSCredentialScope scope = AWSCredentialScope(
      region: region,
      service: AWSService.iot,
    );
    final AWSHttpRequest request = AWSHttpRequest(
      method: AWSHttpMethod.get,
      uri: Uri.parse(canonicalRequest),
    );

    // Sign and send the HTTP request
    final Uri signedRequest = await signer.presign(
      request,
      credentialScope: scope,
      expiresIn: const Duration(hours: 1),
    );
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // The client id unique to your device
    // defaults to AWS IoT Device "name"
    // const String clientId = 'smartThing';
    // MQTT test client:
    const String clientId = 'iotconsole-4cc4a684-a14b-473f-a4dc-99911ef994a8';

    // Create the client
    final MqttServerClient client =
        MqttServerClient(signedRequest.toString(), clientId)
          ..useWebSocket = true
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
