import 'package:dio/dio.dart';
import 'package:dogs/data/dogs_state.dart';
import 'package:dogs/models/dogs_list.dart';
import 'package:dogs/models/random_dog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final randomDogsProvider = StateNotifierProvider.autoDispose<DogsDataController,
    (DogsState, List<String>)>((ref) => DogsDataController());

final dogsByBreedProvider = StateNotifierProvider.autoDispose<
    DogsDataController, (DogsState, List<String>)>((ref) {
  ref.keepAlive();
  return DogsDataController();
});

class DogsDataController extends StateNotifier<(DogsState, List<String>)> {
  DogsDataController() : super((DogsState.loading, []));
  final Dio _dio = Dio();

  void getRandomDogs() async {
    try {
      state = (DogsState.loading, []);
      final response =
          await _dio.get("https://dog.ceo/api/breeds/image/random/20");
      DogsList randomDogs = DogsList.fromJson(response.data);

      if (randomDogs.message.isNotEmpty) {
        state = (DogsState.loaded, randomDogs.message);
        return;
      }
      state = (DogsState.error, []);
    } catch (e) {
      state = (DogsState.error, []);
    }
  }

  void getDogsByBreed({required String breed}) async {
    try {
      state = (DogsState.loading, []);
      final response =
          await _dio.get("https://dog.ceo/api/breed/$breed/images");
      DogsList randomDogs = DogsList.fromJson(response.data);

      if (randomDogs.message.isNotEmpty) {
        state = (DogsState.loaded, randomDogs.message);
        return;
      }
      state = (DogsState.error, []);
    } catch (e) {
      state = (DogsState.error, []);
    }
  }

  void getRandomDogsByBreed({required String breed}) async {
    try {
      state = (DogsState.loading, []);
      final response =
          await _dio.get("https://dog.ceo/api/breed/$breed/images/random");
      RandomDogsByBreedOrSubBread randomDogs =
          RandomDogsByBreedOrSubBread.fromJson(response.data);

      if (randomDogs.message.isNotEmpty) {
        state = (DogsState.loaded, [randomDogs.message]);
        return;
      }
      state = (DogsState.error, []);
    } catch (e) {
      state = (DogsState.error, []);
    }
  }
}
