import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IndicesCard extends StatefulWidget {
  final indice;
  final pushService;

  const IndicesCard({
    Key? key,
    required this.indice,
    required this.pushService,
  }) : super(key: key);

  @override
  State<IndicesCard> createState() => _IndicesCardState();
}

class _IndicesCardState extends State<IndicesCard> {
  final numberFormat = new NumberFormat("##,###.0000", "es_US");
  final decimalFormat = new NumberFormat("###.0000", "es_US");

  @override
  void initState() {
    widget.pushService.subscription('/${widget.indice.idNotation}', (data) {
      if (mounted) {
        setState(() {
          widget.indice.tend =
              (double.parse(data["performance"]) > 0.0) ? "up" : "down";
          widget.indice.price =
              numberFormat.format(double.parse(data["price"]));
          widget.indice.performancePct =
              decimalFormat.format(double.parse(data["performance_pct"]));
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.pushService.unsubscription('/${widget.indice.idNotation}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                widget.indice.name,
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
                                  widget.indice.price,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: (widget.indice.tend == "up")
                                          ? Colors.green[700]
                                          : Colors.red[700],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(widget.indice.performancePct,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
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
}
