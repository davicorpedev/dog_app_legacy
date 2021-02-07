import 'dart:convert';


import 'package:dog_app/core/features/dog/data/models/dog_model.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';


void main() {
  group("Dog", () {
    final tDogModel = DogModel(
      id: "test",
      url: "test",
      breeds: [
        DogBreedModel(
          id: 1,
          name: "test",
          temperament: "test",
          lifeSpan: "test",
          origin: "test",
        ),
      ],
    );

    test("should be a subclass of Dog entity", () async {
      expect(tDogModel, isA<Dog>());
    });

    group("fromJson", () {
      test("should return a valid object", () {
        final Map<String, dynamic> jsonMap = json.decode(fixture("dog.json"));

        final result = DogModel.fromJson(jsonMap);

        expect(result, tDogModel);
      });
    });
  });

  group("DogBreed", () {
    DogBreedModel tDogBreedModel = DogBreedModel(
      id: 1,
      name: "test",
      temperament: "test",
      lifeSpan: "test",
      origin: "test",
    );

    test("should be a subclass of DogBreed entity", () async {
      expect(tDogBreedModel, isA<DogBreed>());
    });

    group("fromJson", () {
      test("should return a valid object", () {
        final Map<String, dynamic> jsonMap = json.decode(fixture("breed.json"));

        final result = DogBreedModel.fromJson(jsonMap);

        expect(result, tDogBreedModel);
      });
    });
  });
}
