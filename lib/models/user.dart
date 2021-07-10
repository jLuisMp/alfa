
class User {
  final int? id;
  final String name;
  final String city;
  final String country;
  final String gender;
  final String? email;

  User(
    { this.id,
      required this.name,
      required this.city,
      required this.gender,
      required this.country,
      this.email});

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        city = res["city"],
        gender =res["gender"],
        country = res["country"],
        email = res["email"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'city': city, 'country': country,'gender':gender, 'email': email};
  }
}