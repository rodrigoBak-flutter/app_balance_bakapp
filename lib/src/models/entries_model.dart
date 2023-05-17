import 'dart:convert';

EntriesModel entriesModelFromJson(String str) =>
    EntriesModel.fromJson(json.decode(str));

String entriesModelToJson(EntriesModel data) => json.encode(data.toJson());

class EntriesModel {
  int? id;
  int day;
  int month;
  int year;
  String comment;
  double entries;

  EntriesModel({
    this.id,
    this.day = 0,
    this.month = 0,
    this.year = 0,
    this.comment = '',
    this.entries = 0.0,
  });

  factory EntriesModel.fromJson(Map<String, dynamic> json) => EntriesModel(
        id: json["id"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        comment: json["comment"],
        entries: json["entries"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "month": month,
        "year": year,
        "comment": comment,
        "entries": entries,
      };
}
