import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infomercados/constants/app_textstyle.dart';
import 'package:infomercados/constants/functions.dart';

class InstrumentsCard extends StatefulWidget {
  final indice;
  final pushService;

  const InstrumentsCard(
      {Key? key, required this.indice, required this.pushService})
      : super(key: key);

  @override
  State<InstrumentsCard> createState() => _InstrumentsCardState();
}

class _InstrumentsCardState extends State<InstrumentsCard>{
  final Utils utils = Utils();
  double _performanceRaw = 0.0;

  @override
  void initState() {
    widget.pushService.subscription('/${widget.indice.idNotation}', (data) {
      if (mounted){

        setState(() {

          widget.indice.tend =
            (_performanceRaw > double.parse(data["performance"])) ? "up" : "down";
          _performanceRaw = double.parse(data["performance"]);
          widget.indice.price = utils.numberFormat(double.parse(data["price"]), 4, ',', '.', false);
          widget.indice.performancePct =
            utils.numberFormat(double.parse(data["performance_pct"]) , 4, ',', '.', true);

          utils.setTimeout(() {
            setState((){


            });

          }, 500);

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
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFFE0E0E0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.indice.name,
                    style: ApptextStyle.LISTTILE_TITLE,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.indice.price,
                    style: ApptextStyle.LISTTILE_TITLE,
                  ),
                  Row(
                    children: [
                      widget.indice.tend == "up"
                          ? Icon(
                              FontAwesomeIcons.levelUpAlt,
                              size: 10,
                              color: Colors.green,
                            )
                          : Icon(
                              FontAwesomeIcons.levelDownAlt,
                              size: 10,
                              color: Colors.red,
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: (widget.indice.tend == "up") ? Colors.green[700] : Colors.red[700],
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          widget.indice.performancePct,
                          style: ApptextStyle.LISTTILE_SUB_TITLE,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
