// To parse this JSON data, do
//
//     final push = pushFromMap(jsonString);

import 'dart:convert';

class Push {
    Push({
        required this.id,
        required this.channel,
        required this.successful,
        this.version,
        this.supportedConnectionTypes,
        this.clientId,
        required this.advice,
    });

    String id;
    String channel;
    bool successful;
    String? version;
    List<String>? supportedConnectionTypes;
    String? clientId;
    Advice advice;

    factory Push.fromJson(String str) => Push.fromMap(json.decode(str)[0]);

    String toJson() => json.encode(toMap());

    factory Push.fromMap(Map<String, dynamic> json) => Push(
        id: json["id"],
        channel: json["channel"],
        successful: json["successful"],
        version: json["version"],
        supportedConnectionTypes: List<String>.from(json["supportedConnectionTypes"].map((x) => x)),
        clientId: json["clientId"],
        advice: Advice.fromMap(json["advice"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "channel": channel,
        "successful": successful,
        "version": version,
        "supportedConnectionTypes": List<dynamic>.from(supportedConnectionTypes!.map((x) => x)),
        "clientId": clientId,
        "advice": advice.toMap(),
    };
}

class Advice {
    Advice({
        required this.reconnect,
        required this.interval,
        required this.timeout,
    });

    String reconnect;
    int interval;
    int timeout;

    factory Advice.fromJson(String str) => Advice.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Advice.fromMap(Map<String, dynamic> json) => Advice(
        reconnect: json["reconnect"],
        interval: json["interval"],
        timeout: json["timeout"],
    );

    Map<String, dynamic> toMap() => {
        "reconnect": reconnect,
        "interval": interval,
        "timeout": timeout,
    };
}
