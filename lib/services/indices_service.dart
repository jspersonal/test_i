import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:infomercados/models/models.dart';
import 'package:intl/intl.dart';

class IndicesService extends ChangeNotifier {
  final String _baseUrl = 'finmarketsbackup.cl';
  late List<EntryIndices> indices = [];
  late EntryIndices selectedIndice;

  final numberFormat = new NumberFormat("##,###.00#", "en_US");
  final decimalFormat = new NumberFormat("#0.0000", "en_US");

  bool isLoading = true;

  IndicesService() {
    this.loadIndices();
  }

  Future<List<EntryIndices>> loadIndices() async {
    this.indices = [];

    this.isLoading = true;

    final url = Uri.https(
        _baseUrl, '/jsepulveda/btgpactual-original/jsonv2/currencies.html');
    final resp = await http.get(url);

    final indicesMap = Indices.fromJson(resp.body).data.entry;

    indicesMap.forEach((element) {
      this.indices.add(element);
    });

    this.isLoading = false;
    notifyListeners();

    return this.indices;
  }

  void updateData(data) {
    // print("PASO UPDATE");

    this.indices.forEach((element) {
      // print(element.idNotation.toString());
      if (element.idNotation.toString() == data["id_notation"]) {
        // print("encontro");
        element.price = numberFormat.format(double.parse(data["price"]));
        element.performance =
            decimalFormat.format(double.parse(data["performance"]));
      }
    });
    // notifyListeners();
  }
}
