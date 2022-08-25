import 'package:flutter/material.dart';
import 'package:push_client/push_client.dart';
import 'package:logging/logging.dart';

class PushService with ChangeNotifier {
  late Map<String, MessageHandler> _clientExtensionIncoming;
  late FayeClient _client;
  late Map<String, Subscription> _instruments = {};

  get clientPush => this._client;

  void get clearInstrumentsList => this._instruments = {};

  PushService() {
    this._initConfig();
  }

  void _initConfig() {
    this._client = FayeClient('wss://push2.finmarkets.cl/push',
        protocols: ['websocket'], logLevel: Level.ALL);

    this._clientExtensionIncoming = <String, MessageHandler>{
      'outgoing': (message) {
        message.ext = {
          "host": "finmarketslive.cl",
          // "token": "1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1"
        };
        return message;
      }
    };

    // this._client.webSocketChannelProvider

    this._client.addExtension(_clientExtensionIncoming);

    this._client.connect();

    // this._client.stateStream;
  }

  void disconnect() {
    this._client.disconnect();
  }

  void subscription(String channel, Function callback) async {
    if (!this._instruments.containsKey(channel)) {
      // this._client.subscribe(channel);
      var subscribe = await this._client.subscribe(channel, callback: (data) {
        callback(data);
      });

      // this._instruments.addAll({channel: subscribe});
    } else {
      print("Ya existe la subscripcion");
    }
  }

  void listInstrument() {
    print(this._instruments);
  }

  void unsubscription(String channel) {
    // print(channel);

    if (this._instruments.containsKey(channel)) {
      // print("desubscribio - " + channel);

      var subs = this._instruments[channel];

      this._client.unsubscribe(channel, subs!);

      // Quitando Canal del listaado de instrumentos suscritos
      this._instruments.remove(channel);
    }
  }

  get state => this._client.state;
}
