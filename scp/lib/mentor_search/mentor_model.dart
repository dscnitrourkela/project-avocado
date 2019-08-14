// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    Hits hits;

    Response({
        this.hits,
    });

    factory Response.fromJson(Map<String, dynamic> json) => new Response(
        hits: Hits.fromJson(json["hits"]),
    );

    Map<String, dynamic> toJson() => {
        "hits": hits.toJson(),
    };
}

class Hits {
    List<Hit> hits;

    Hits({
        this.hits,
    });

    factory Hits.fromJson(Map<String, dynamic> json) => new Hits(
        hits: new List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "hits": new List<dynamic>.from(hits.map((x) => x.toJson())),
    };
}

class Hit {
    String id;
    Source source;

    Hit({
        this.id,
        this.source,
    });

    factory Hit.fromJson(Map<String, dynamic> json) => new Hit(
        id: json["_id"],
        source: Source.fromJson(json["_source"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "_source": source.toJson(),
    };
}

class Source {
    String rollNo;
    String name;
    String mentorName;
    String mentorContact;
    String mentorEmail;

    Source({
        this.rollNo,
        this.name,
        this.mentorName,
        this.mentorContact,
        this.mentorEmail,
    });

    factory Source.fromJson(Map<String, dynamic> json) => new Source(
        rollNo: json["rollNo"],
        name: json["name"],
        mentorName: json["mentor_name"],
        mentorContact: json["mentor_contact"],
        mentorEmail: json["mentor_email"],
    );

    Map<String, dynamic> toJson() => {
        "rollNo": rollNo,
        "name": name,
        "mentor_name": mentorName,
        "mentor_contact": mentorContact,
        "mentor_email": mentorEmail,
    };
}
