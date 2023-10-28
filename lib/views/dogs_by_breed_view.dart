import 'package:dogs/data/dogs_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DogsByBreedView extends ConsumerStatefulWidget {
  const DogsByBreedView({super.key});

  @override
  ConsumerState<DogsByBreedView> createState() => _RandomDogsViewState();
}

class _RandomDogsViewState extends ConsumerState<DogsByBreedView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(dogsByBreedProvider);
        if (state.$1 == DogsState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.$1 == DogsState.loaded) {
          return Column(
            children: state.$2
                .map((dogImage) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.network(
                        dogImage,
                        errorBuilder: (context, error, stackTrace) =>
                            const Column(
                          children: [
                            Icon(Icons.error),
                            Text("Failed To Fetch Image")
                          ],
                        ),
                      ),
                    ))
                .toList(),
          );
        }
        if (state.$1 == DogsState.error) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
        return const SizedBox();
      },
    );
  }
}
