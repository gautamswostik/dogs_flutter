import 'dart:convert';

RandomDogsByBreedOrSubBread randomDogsByBreedOrSubBreadFromJson(String str) =>
    RandomDogsByBreedOrSubBread.fromJson(json.decode(str));

String randomDogsByBreedOrSubBreadToJson(RandomDogsByBreedOrSubBread data) =>
    json.encode(data.toJson());

class RandomDogsByBreedOrSubBread {
  String message;
  String status;

  RandomDogsByBreedOrSubBread({
    required this.message,
    required this.status,
  });

  factory RandomDogsByBreedOrSubBread.fromJson(Map<String, dynamic> json) =>
      RandomDogsByBreedOrSubBread(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
