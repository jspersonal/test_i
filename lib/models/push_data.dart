// To parse this JSON data, do
//
//     final pushData = pushDataFromMap(jsonString);

import 'package:flutter/material.dart';
import 'dart:convert';

class PushData {
  PushData(
      {required this.idNotation,
      required this.quality,
      required this.price,
      required this.datePrice,
      required this.performance,
      required this.performancePct,
      required this.totalMoney,
      required this.totalVolume,
      required this.high,
      required this.dateHigh,
      required this.low,
      required this.dateLow,
      required this.bid,
      required this.ask,
      required this.volumeBid,
      required this.volumeAsk,
      required this.avgLastPrice,
      required this.datetimeAvgLastPrice,
      required this.amountOperation,
      required this.name,
      this.color});

  String idNotation;
  int quality;
  String price;
  DateTime datePrice;
  String performance;
  String performancePct;
  String totalMoney;
  String totalVolume;
  String high;
  DateTime dateHigh;
  String low;
  DateTime dateLow;
  String bid;
  String ask;
  String volumeBid;
  String volumeAsk;
  String avgLastPrice;
  String datetimeAvgLastPrice;
  String amountOperation;
  String name;
  Color? color;

  factory PushData.fromJson(String str) => PushData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PushData.fromMap(Map<String, dynamic> json) => PushData(
        idNotation: json["id_notation"],
        quality: json["quality"],
        price: json["price"],
        datePrice: DateTime.parse(json["date_price"]),
        performance: json["performance"],
        performancePct: json["performance_pct"],
        totalMoney: json["total_money"],
        totalVolume: json["total_volume"],
        high: json["high"],
        dateHigh: DateTime.parse(json["date_high"]),
        low: json["low"],
        dateLow: DateTime.parse(json["date_low"]),
        bid: json["bid"],
        ask: json["ask"],
        volumeBid: json["volume_bid"],
        volumeAsk: json["volume_ask"],
        avgLastPrice: json["avgLastPrice"],
        datetimeAvgLastPrice: json["datetimeAvgLastPrice"],
        amountOperation: json["amountOperation"],
        name: json["name"],
        color: Color(json["color"]),
      );

  Map<String, dynamic> toMap() => {
        "id_notation": idNotation,
        "quality": quality,
        "price": price,
        "date_price": datePrice.toIso8601String(),
        "performance": performance,
        "performance_pct": performancePct,
        "total_money": totalMoney,
        "total_volume": totalVolume,
        "high": high,
        "date_high": dateHigh.toIso8601String(),
        "low": low,
        "date_low": dateLow.toIso8601String(),
        "bid": bid,
        "ask": ask,
        "volume_bid": volumeBid,
        "volume_ask": volumeAsk,
        "avgLastPrice": avgLastPrice,
        "datetimeAvgLastPrice": datetimeAvgLastPrice,
        "amountOperation": amountOperation,
        "name": name,
        "color": color,
      };

  @override
  String toString() {
    return 'PushData(idNotation: $idNotation, quality: $quality, price: $price, datePrice: $datePrice, performance: $performance, performancePct: $performancePct, totalMoney: $totalMoney, totalVolume: $totalVolume, high: $high, dateHigh: $dateHigh, low: $low, dateLow: $dateLow, bid: $bid, ask: $ask, volumeBid: $volumeBid, volumeAsk: $volumeAsk, avgLastPrice: $avgLastPrice, datetimeAvgLastPrice: $datetimeAvgLastPrice, amountOperation: $amountOperation, name: $name)';
  }
}
