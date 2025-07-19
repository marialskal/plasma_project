class User {
  final String name;
  final String email;
  final String address;
  final int points;
  final String profilePicture;

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.points,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      address: json["address"] ?? "",
      points: json["points"] ?? 0,
      profilePicture: json["profile_picture"] ?? "",
    );
  }
}
