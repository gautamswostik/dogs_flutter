import 'package:dogs/data/dog_breed_data_controller.dart';
import 'package:dogs/data/dogs_data_controller.dart';
import 'package:dogs/data/dogs_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DogsBreedListScreen extends ConsumerStatefulWidget {
  const DogsBreedListScreen({super.key, required this.showSubBreed});
  final bool showSubBreed;

  @override
  ConsumerState<DogsBreedListScreen> createState() =>
      _DogsBreedListScreenState();
}

class _DogsBreedListScreenState extends ConsumerState<DogsBreedListScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ref.read(dogsBreedProvider.notifier).getDogsBreed();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(dogsBreedProvider);
        if (state.$1 == DogsState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.$1 == DogsState.loaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.$2.entries.map((breed) {
                if (widget.showSubBreed && breed.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: breed.value
                          .map((subBreed) => InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pop("${breed.key}/$subBreed");
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Text(subBreed),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(breed.key);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Text(breed.key),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
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
