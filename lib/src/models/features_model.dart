import 'dart:convert';

FeaturesModel featuresModelFromJson(String str) =>
    FeaturesModel.fromJson(json.decode(str));

String featuresModelToJson(FeaturesModel data) => json.encode(data.toJson());

class FeaturesModel {
  int? id;
  String category;
  String color;
  String icon;

  FeaturesModel({
    this.id,
    this.category = '',
    this.color = '#baf748',
    this.icon = 'apartment_rounded',
  });

  factory FeaturesModel.fromJson(Map<String, dynamic> json) => FeaturesModel(
        id: json["id"],
        category: json["category"],
        color: json["color"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "color": color,
        "icon": icon,
      };
}
