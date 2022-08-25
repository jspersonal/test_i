import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndicesCard extends StatefulWidget {
  final indice;

  const IndicesCard({
    Key? key,
    required this.indice,
  }) : super(key: key);

  @override
  State<IndicesCard> createState() => _IndicesCardState();
}

class _IndicesCardState extends State<IndicesCard> {
  @override
  Widget build(BuildContext context) {
    // print(widget.indice);

    // return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 100,
        decoration: _cardBorders(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                widget.indice["name"],
                                // widget.indice.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.indice["price"],
                                  // widget.indice.price,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(widget.indice["performance"],
                                    // widget.indice.performance,
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w700,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // _IndiceDetails(name: indice.name)
            // Text(indice.name)
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);

  @override
  void dispose() {
    // subscription.cancel();
    super.dispose();
  }
}
