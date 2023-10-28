import 'package:dio/dio.dart';
import 'package:dogs/data/dogs_state.dart';
import 'package:dogs/models/dogs_breed.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dogsBreedProvider = StateNotifierProvider.autoDispose<
    DogsByBreedDataController,
    (
      DogsState,
      Map<String, List<String>>
    )>((ref) => DogsByBreedDataController());

class DogsByBreedDataController
    extends StateNotifier<(DogsState, Map<String, List<String>>)> {
  DogsByBreedDataController() : super((DogsState.loading, {}));
  final Dio _dio = Dio();

  void getDogsBreed() async {
    try {
      state = (DogsState.loading, {});
      final response = await _dio.get("https://dog.ceo/api/breeds/list/all");
      DogsBreed dogsBreed = DogsBreed.fromJson(response.data);

      if (dogsBreed.message.isNotEmpty) {
        List<String> dogsBreeds = [];
        for (MapEntry data in dogsBreed.message.entries) {
          dogsBreeds.add(data.key);
        }
        state = (DogsState.loaded, dogsBreed.message);
        return;
      }
      state = (DogsState.error, {});
    } catch (e) {
      state = (DogsState.error, {});
    }
  }
}
