import 'package:scholar_chat/model/servicemodel.dart';

const String baseUrl = "http://yourdomain.com";

class CategoryModel {
  final int id;
  final String name;
  final String? icon;
  final String? iconUrl;
  final List<ServiceModel> services;

  CategoryModel({
    required this.id,
    required this.name,
    this.icon,
    required this.iconUrl,
    required this.services,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      iconUrl: "$baseUrl${json['icon_url']}",
      services: json['services'] != null
          ? List<ServiceModel>.from(
              json['services'].map((s) => ServiceModel.fromJson(s)))
          : [],
    );
  }
}

