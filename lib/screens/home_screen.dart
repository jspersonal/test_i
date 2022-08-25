import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infomercados/models/push.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  final WebSocketChannel channel = IOWebSocketChannel.connect(Uri.parse('wss://push2.finmarketslive.cl/push'));

  @override
  State<HomeScreen> createState() => _HomeScreenState(channel);
}

class _HomeScreenState extends State<HomeScreen> {

  final WebSocketChannel channel;
  String price = '';

  _HomeScreenState(this.channel) {

    channel.sink.add('{"channel":"/meta/handshake","version":"1.0","supportedConnectionTypes":["websocket"],"id":"1","ext":{"token":"1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1","host":"prueba.finmarketslive.cl"}}');

    channel.stream.listen((data) {
      print(data);
      final _json = jsonDecode(data.toString())[0];
      // _clientId = _json["clientId"];

      // channel.sink.add('{"channel":"/meta/subscribe","clientId":"9a01zigwyqrreak07d9s5t0y14xxo4k","subscription":"/31","id":"3","ext":{"token":"1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1","host":"prueba.finmarketslive.cl"}}');

      if (_json["channel"] == '/meta/handshake' && _json["successful"]){
        print('PASO');
        channel.sink.add('{"channel":"/meta/connect","clientId":"${_json["clientId"]}","connectionType":"websocket","id":"2","ext":{"token":"1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1","host":"prueba.finmarketslive.cl"}}');
      }else{
        if (_json["channel"] == '/meta/connect' && _json["successful"]){
          print("suscribiendo Instrumento..");
          channel.sink.add('{"channel":"/meta/subscribe","subscription":"/27","clientId":"${_json["clientId"]}","id":"3","ext":{"host":"prueba.finmarketslive.cl"}}');
        }else{
          if (_json["channel"] == '/meta/subscribe' && _json["successful"]){
            print("suscrito correctamente...");
          }
          print("recibiendo datos..");
          print(_json);
          setState(() {
            if (_json["data"] != null){
              price = _json["data"]["price"];
            }
          });
        }
      }






    });

  }


  @override
  Widget build(BuildContext context) {

    // print(_channel);

    // _channel.stream.l



    // _channel.sink.add('[{"channel":"/meta/handshake","version":"1.0","supportedConnectionTypes":["websocket"],"id":"1","ext":{"token":"1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1","host":"finmarketslive.cl","hash":"8eff38cf968f2538cff0c871d46c923f8e5343181047c4f21e65e3978940550d","ts":"D1633468570"}}]');


//     MSG OUT => {"channel":"/meta/handshake","version":"1.0","supportedConnectionTypes":["websocket"],"id":"1","ext":{"token":"1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1","host":"www.finmarketslive.cl","hash":"8eff38cf968f2538cff0c871d46c923f8e5343181047c4f21e65e3978940550d","ts":"D1633468570"}}
// MSG IN => [{"id":"1","channel":"/meta/handshake","successful":true,"version":"1.0","supportedConnectionTypes":["long-polling","cross-origin-long-polling","callback-polling","websocket","eventsource","in-process"],"clientId":"bpdt50sluoe6gya9a4ddzxzxe2fp1w1","advice":{"reconnect":"retry","interval":0,"timeout":25000}}]
// MSG OUT => {"channel":"/meta/connect","clientId":"bpdt50sluoe6gya9a4ddzxzxe2fp1w1","connectionType":"websocket","id":"x","ext":{"token":"1NlzqkpWhbgcQGkFHYzSJ7mH721fENJ1","host":"www.finmarketslive.cl","hash":"8eff38cf968f2538cff0c871d46c923f8e5343181047c4f21e65e3978940550d","ts":"D1633468570"}}


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Container(
          color: Colors.red,
          child: Column(
            children: [
              Text(price),
              // StreamBuilder(
              //   stream: _channel.stream,
              //   builder: (context, snapshot) {

              //     switch (snapshot.connectionState) {
              //       case ConnectionState.waiting:
              //       case ConnectionState.none:
              //         print('Conectando...');
              //         return CircularProgressIndicator();
              //       case ConnectionState.active:
              //         print(jsonDecode(snapshot.data.toString()));
              //         // print(snapshot.data);
              //         if (snapshot.hasData){

              //           final _json = jsonDecode(snapshot.data.toString())[0];
              //           if (_json["channel"] == '/meta/handshake' && _json["successful"]){
              //             print('PASO');
              //             _channel.sink.add('[{"channel":"/meta/connect","clientId":"${_json["clientId"]}","connectionType":"websocket","ext":{"host":"finmarketslive.cl"}}]');

              //           }else{
              //             print("suscribir");

              //             if (_sw){
              //               print("suscribio!!");
              //               _sw = false;
              //               _channel.sink.add('[{"channel:"/meta/subscribe","subscription","/27","clientId":"${_json["clientId"]}","ext":{"host":"finmarketslive.cl"}}]');
              //             }
              //             // if (_json["channel"] == '/meta/connect' && _json["successful"]){
              //             //   print(_json);
              //             // }else{

              //             // }
              //             print(_json.toString());
              //           }
              //         //   print(_json.clientId);

              //         }
              //         // _channel.stream.listen((message){
              //         //   print(message);
              //         // });
              //         break;
              //       default:
              //     }

              //     return Text(snapshot.hasData ? '${snapshot.data}' : '');

              //   },
              // )
            ],
          ),
        ),
      ),

    );
  }

  @override
  void dispose(){
    channel.sink.close();
    super.dispose();
  }

}