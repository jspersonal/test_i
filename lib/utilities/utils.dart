import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  static double roundDouble(dynamic value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).floorToDouble().toDouble() / mod);
  }

  /// Formato para Numeros.
  ///
  /// [value] Valor del numero.
  ///
  /// [decimals] decimales para el formato, por defecto 2 decimales.
  static numberFormat(dynamic value,
      [int decimals = 2,
      String separadorDecimales = ',',
      String separadorMiles = '.',
      bool bSing = false,
      String additionalString = '']) {
    var signo = (bSing && value > 0) ? '+' : '';

    value = roundDouble(value, decimals);
    var tmp = value.toString().split('.');

    var numero = tmp[0];
    var decimales = tmp[1];

    separadorDecimales = (separadorDecimales == '') ? ',' : separadorDecimales;
    separadorMiles = (separadorMiles == '') ? '.' : separadorMiles;

    var miles = RegExp("(-?[0-9]+)([0-9]{3})");
    while (numero.contains(miles)) {
      miles.allMatches(numero).forEach((match) {
        numero = numero.replaceAll(
            miles,
            match.group(1).toString() +
                separadorMiles +
                match.group(2).toString());
      });
    }

    var numeroFormateado = '';
    if (decimales == '0') {
      numeroFormateado = signo +
          numero +
          separadorDecimales +
          decimales +
          '0' +
          additionalString;
    } else {
      numeroFormateado =
          signo + numero + separadorDecimales + decimales + additionalString;
    }

    return numeroFormateado;
  }

  /// Retorna el Color de la variacion dependiendo del valor
  /// value - Valor
  static int getTendByValue(dynamic value) {
    if (value > 0) {
      return 0xFFCCCC00;
      //  Colors.green[300];
    } else if (value < 0) {
      return 0xFFFF5733; //Colors.red[300];
    } else if (value == 0) {
      return 0xFFFFFFCC; //Colors.grey[300];
    } else {
      return 0xFFFFFFCC; //Colors.grey[300];
    }
  }
}
