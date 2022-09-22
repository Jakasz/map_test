import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String token;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "token": token,
  };

  static List<Token> loadFromDB(List snapshot) {
    return snapshot.map((data) {
      return Token.fromJson(data);
    }).toList();
  }
}
