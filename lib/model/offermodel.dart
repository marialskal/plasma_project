class OfferModel {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final String? discountPercentage;
  final String? startDatetime;
  final String? endDatetime;
  final String? points;

  OfferModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.discountPercentage,
    this.startDatetime,
    this.endDatetime,
    this.points,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'], 
      discountPercentage: json['discount_percentage'],
      startDatetime: json['start_datetime'],
      endDatetime: json['end_datetime'],
      points: json['points'],
    );
  }
}