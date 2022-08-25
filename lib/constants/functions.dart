import 'dart:math';
import 'dart:async';

class Utils{

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).floorToDouble().toDouble() / mod);
  }

  numberFormat(
    double value,
    [int decimals = 2,
    String separadorDecimales = ',',
    String separadorMiles = '.',
    bool bSing = false]){

    var signo = (bSing && value > 0) ? '+' : '';

    value = roundDouble(value, decimals);
    var tmp = value.toString().split('.');

    var numero = tmp[0];
    var decimales = tmp[1];

    separadorDecimales = (separadorDecimales == '') ? ',' : separadorDecimales;
    separadorMiles = (separadorMiles == '') ? '.' : separadorMiles;

    var miles = RegExp("(-?[0-9]+)([0-9]{3})");
    while (numero.contains(miles)){
      miles.allMatches(numero).forEach((match) {
        numero = numero.replaceAll(miles, match.group(1).toString() + separadorMiles + match.group(2).toString());
      });
    }

    return signo + numero + separadorDecimales + decimales;

  }

  Timer setTimeout(callback, [int duration = 1000]) {
    return Timer(Duration(milliseconds: duration), callback);
  }

  void clearTimeout(Timer t) {
    t.cancel();
  }

}