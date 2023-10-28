import 'package:dogs/data/dogs_data_controller.dart';
import 'package:dogs/views/dogs_breed_list_screen.dart';
import 'package:dogs/views/dogs_by_breed_view.dart';
import 'package:dogs/views/random_breed_dogs_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int currentIndex = 0;

  final List<String> options = [
    "By Random Breed",
    "By Specific Breed",
    "By Random Breed and sub breed",
    "By Specific Breed and sub Breed"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dogs"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: options.map((e) {
                    int index = options.indexOf(e);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: RawChip(
                        onPressed: () async {
                          if (index == 1 || index == 2 || index == 3) {
                            await showDialog<String>(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: SingleChildScrollView(
                                    child: DogsBreedListScreen(
                                      showSubBreed: index == 3 || index == 2,
                                    ),
                                  ),
                                );
                              },
                            ).then((value) {
                              if (value != null && value.isNotEmpty) {
                                setState(() {
                                  currentIndex = index;
                                });
                                if (index == 2) {
                                  ref
                                      .read(dogsByBreedProvider.notifier)
                                      .getRandomDogsByBreed(breed: value);
                                  return;
                                }
                                ref
                                    .read(dogsByBreedProvider.notifier)
                                    .getDogsByBreed(breed: value);
                              }
                            });
                            return;
                          }
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        backgroundColor:
                            index == currentIndex ? Colors.amberAccent : null,
                        label: Text(e),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: currentDogsScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget currentDogsScreen() {
    if (currentIndex == 0) {
      return const RandomDogsView();
    }
    return const DogsByBreedView();
  }
}
