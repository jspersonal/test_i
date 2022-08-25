import 'package:flutter/material.dart';

import 'package:push_client/push_client.dart';

class Home2Screen extends StatefulWidget {
  Home2Screen({Key? key}) : super(key: key);

  final client = FayeClient('wss://push2.finmarketslive.cl/push');

  @override
  State<Home2Screen> createState() => _Home2ScreenState(client);
}

class _Home2ScreenState extends State<Home2Screen> {
  String price = '';
  List<String> instrumentSubscritos = [];

  var client;
  var subscribe;

  _Home2ScreenState(this.client) {
    Map<String, MessageHandler> clientExtensionIncoming;

    clientExtensionIncoming = <String, MessageHandler>{
      'outgoing': (message) {
        message.ext = {"host": "prueba.finmarketslive.cl"};
        return message;
      }
    };

    client.addExtension(clientExtensionIncoming);
    subscribe = client.subscribe('/27', callback: (data) {
      print(data);
      setState(() {
        price = data["price"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(price),
        ),
      ),
    );
  }
}
