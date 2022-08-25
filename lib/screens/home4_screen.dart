import 'package:flutter/material.dart';
import 'package:infomercados/screens/screens.dart';
import 'package:infomercados/services/indices_service.dart';
import 'package:infomercados/services/push_service.dart';
import 'package:infomercados/widgets/instruments_card.dart';
import 'package:provider/provider.dart';

class Home4Screen extends StatelessWidget {
  const Home4Screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final indicesService = Provider.of<IndicesService>(context);
    final pushService = Provider.of<PushService>(context);

    if( indicesService.isLoading ) return LoadingScreen();

    print(pushService.state);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            title: Text("Monedas"),
            centerTitle: true,
            pinned: true,
            floating: true,
            leading: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent)
              ),
              onPressed: () {

                indicesService.loadIndices();

              },
              child: Icon(Icons.refresh),
            ),
            flexibleSpace: Image.asset(
              'assets/images/global-currency-exchange-network-symbol-concept-illustration-vector.jpeg',
              fit: BoxFit.cover,

            ),

          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index){
                return InstrumentsCard(
                  indice: indicesService.indices[index],
                  pushService: pushService
                );
              },
              childCount: indicesService.indices.length
            ),
          )
        ],
        // child: SafeArea(
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 10),
        //     child: ListView.separated(
        //       // padding: EdgeInsets.zero,
        //       shrinkWrap: true,
        //       // physics: NeverScrollableScrollPhysics(),
        //       itemCount: indicesService.indices.length,
        //       separatorBuilder: ( BuildContext context, int index ) {
        //         return SizedBox(
        //           height: 10,
        //         );

        //         // return GestureDetector(
        //         //   onTap: () {

        //         //   },
        //         //   child: IndicesCard(
        //         //     indice: indicesService.indices[index],
        //         //     pushService: pushService,
        //         //   ),

        //         // );
        //       }, itemBuilder: (BuildContext context, int index) {
        //         // return IndicesCard(
        //         //     indice: indicesService.indices[index],
        //         //     pushService: pushService,
        //         // );
        //         return InstrumentsCard(
        //           indice: indicesService.indices[index],
        //           pushService: pushService
        //         );
        //       },
        //     ),
        ),
      );
  }
}