class ServiceModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int points;
  final int duration;
  final String? icon;
  final String? iconUrl;
  bool isFavorite;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.points,
    required this.duration,
    this.iconUrl,
    this.icon,
    this.isFavorite = false,  
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      points: json['points'],
      duration: json['duration'],
      icon: json['icon'],
      iconUrl: json['icon_url'],  
      isFavorite: json['isFavorite'] ?? false,  
    );
  }
}
