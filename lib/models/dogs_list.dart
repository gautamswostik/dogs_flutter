import 'dart:convert';

DogsList dogsListFromJson(String str) => DogsList.fromJson(json.decode(str));

String dogsListToJson(DogsList data) => json.encode(data.toJson());

class DogsList {
  final List<String> message;
  final String status;

  DogsList({
    required this.message,
    required this.status,
  });

  factory DogsList.fromJson(Map<String, dynamic> json) => DogsList(
        message: List<String>.from(json["message"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x)),
        "status": status,
      };
}
