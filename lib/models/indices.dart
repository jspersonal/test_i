// To parse this JSON data, do
//
//     final indices = indicesFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

class Indices {
    Indices({
        required this.data,
    });

    DataIndices data;

    factory Indices.fromJson(String str) => Indices.fromMap(json.decode(str));

    factory Indices.fromMap(Map<String, dynamic> json) => Indices(
        data: DataIndices.fromMap(json["data"]),
    );

}

class DataIndices {
    DataIndices({
        required this.status,
        required this.entry,
    });

    String status;
    List<EntryIndices> entry;

    factory DataIndices.fromJson(String str) => DataIndices.fromMap(json.decode(str));

    factory DataIndices.fromMap(Map<String, dynamic> json) => DataIndices(
        status: json["status"],
        entry: List<EntryIndices>.from(json["entry"].map((x) => EntryIndices.fromMap(x))),
    );

}

class EntryIndices {
    EntryIndices({
        required this.idNotation,
        required this.name,
        required this.date,
        required this.instrumentType,
        required this.price,
        required this.performancePct,
        required this.performance,
        required this.tend,
        required this.icon,
        this.color
    });

    int idNotation;
    String name;
    String date;
    String instrumentType;
    String price;
    String performancePct;
    String performance;
    String tend;
    String icon;
    Color? color;

    factory EntryIndices.fromJson(String str) => EntryIndices.fromMap(json.decode(str));

    factory EntryIndices.fromMap(Map<String, dynamic> json) => EntryIndices(
        idNotation: json["id_notation"],
        name: json["name"],
        date: json["date"],
        instrumentType: json["instrument_type"],
        price: json["price"],
        performancePct: json["performance_pct"],
        performance: json["performance"],
        tend: json["tend"],
        icon: json["icon"],
        color: json["color"],
    );

}
