// import 'package:faye_dart/faye_dart.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infomercados/models/push_data.dart';
import 'package:infomercados/screens/screens.dart';
import 'package:infomercados/services/indices_service.dart';
import 'package:infomercados/services/push_service.dart';
import 'package:infomercados/utilities/utils.dart';
import 'package:provider/provider.dart';

class Home3Screen extends StatefulWidget {
  Home3Screen({Key? key}) : super(key: key);

  @override
  State<Home3Screen> createState() => _Home3ScreenState();
}

class _Home3ScreenState extends State<Home3Screen> {
  final List<dynamic> subscription = [];

  final _streamController = StreamController<Map>();

  @override
  Widget build(BuildContext context) {
    final indicesService = Provider.of<IndicesService>(context);

    final pushService = Provider.of<PushService>(context, listen: false);

    if (indicesService.isLoading) return LoadingScreen();

    indicesService.indices.forEach((element) {
      pushService.subscription('/${element.idNotation}', (data) {
        final performance = element.performance
            .replaceAll(RegExp(r'\+'), '')
            .replaceAll(RegExp(r','), '.');

        data['price'] = Utils.numberFormat(double.parse(data['price']), 4);
        // data['tend'] = Utils.getTendByValue(double.parse(data['performance']));
        data['performance_pct'] = Utils.numberFormat(
            double.parse(data['performance_pct']), 4, ',', '.', true);

        // data["price"] = numberFormat.format(double.parse(data["price"]));
        // data["performance"] =
        //     decimalFormat.format(double.parse(data["performance"]));
        data.addAll({
          "name": element.name,
          "color": Utils.getTendByValue(double.parse(performance))
        });
        print(data);

        _streamController.sink.add(data);

        // indicesService.updateData(data);
      });
    });

    // pushService.listInstrument();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          indicesService.loadIndices();
        },
        child: Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              final pushData = PushData.fromJson(jsonEncode(snapshot.data));
              // debugPrint(pushData.toString());

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: indicesService.indices.length,
                itemBuilder: (context, index) {
                  indicesService.indices
                      .where((element) =>
                          element.idNotation.toString() == pushData.idNotation)
                      .forEach((element) {
                    element.price = pushData.price;
                    element.performance = pushData.performance;
                    element.performancePct = pushData.performancePct;
                    element.color = Color(
                      Utils.getTendByValue(
                        double.parse(
                          pushData.performance
                              .replaceAll(RegExp(r'\+'), '')
                              .replaceAll(RegExp(r','), '.'),
                        ),
                      ),
                    );
                  });

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        // width: 250,
                        // height: 230,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment:
                          //     MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text(indicesService.indices[index].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                'Precio: ',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${indicesService.indices[index].price}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Variación: ',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${indicesService.indices[index].performancePct}%',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Color(
                                      Utils.getTendByValue(
                                        double.parse(
                                          indicesService
                                              .indices[index].performance
                                              .replaceAll(RegExp(r'\+'), '')
                                              .replaceAll(RegExp(r','), '.'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }

            // return children;

            // return Text(snapshot.hasData ? '${snapshot.data}' : 'NADA');

            // ListView.builder(
            //   padding: EdgeInsets.zero,
            //   controller: ,
            //   itemCount: indicesService.indices.length,
            //   itemBuilder: ( BuildContext context, int index ) {

            //     pushService.subscription('/${indicesService.indices[index].idNotation}', (data) {
            //         print(numberFormat.format(double.parse(data["price"])));
            //         indicesService.indices[index].price = numberFormat.format(double.parse(data["price"]));
            //     });

            //     return GestureDetector(
            //       onTap: () {

            //       },

            //       child: IndicesCard(
            //         indice: indicesService.indices[index],
            //       ),

            //     );
            //   }
            // );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

// class _Diseno1 extends StatelessWidget {
//   const _Diseno1({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.black,
//               Colors.black38
//             ]
//           )
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SafeArea(
//               child: Container(
//                 height: MediaQuery.of(context).size.height / 2.6,
//                 // color: Colors.red,
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 25),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(100)
//                           )
//                         ),
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.menu,
//                             color: Colors.black54,
//                           )
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(25),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(65),
//                     topRight: Radius.circular(65)
//                   )
//                 ),
//                 // child: ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount),
//               )
//             ),
//           ],
//         ),
//       ),

//     );
//   }
// }