import 'dart:convert';

ExpensesModel hogwartsModelFromJson(String str) =>
    ExpensesModel.fromJson(json.decode(str));

String hogwartsModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
  int? id;
  int? link;
  int day;
  int month;
  int year;
  String comment;
  double expense;

  ExpensesModel({
    this.id,
    this.link,
    this.day = 0,
    this.month = 0,
    this.year = 0,
    this.comment = "",
    this.expense = 0.0,
  });

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        link: json["link"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        comment: json["comment"],
        expense: json["expense"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "day": day,
        "month": month,
        "year": year,
        "comment": comment,
        "expense": expense,
      };
}
