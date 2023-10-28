import 'dart:convert';

DogsBreed dogsBreedFromJson(String str) => DogsBreed.fromJson(json.decode(str));

String dogsBreedToJson(DogsBreed data) => json.encode(data.toJson());

class DogsBreed {
  Map<String, List<String>> message;
  String status;

  DogsBreed({
    required this.message,
    required this.status,
  });

  factory DogsBreed.fromJson(Map<String, dynamic> json) => DogsBreed(
        message: Map.from(json["message"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
      };
}
