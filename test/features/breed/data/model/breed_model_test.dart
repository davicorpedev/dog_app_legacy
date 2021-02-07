import 'dart:convert';

import 'package:dog_app/features/breed/data/models/breed_model.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tBreedModel = BreedModel(
    id: 1,
    name: "test",
    temperament: "test",
    lifeSpan: "test",
    origin: "test",
    image: "test",
  );

  test("should be a subclass of Breed entity", () async {
    expect(tBreedModel, isA<Breed>());
  });

  group("fromJson", () {
    test("should return a valid object", () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("breed.json"));

      final result = BreedModel.fromJson(jsonMap);

      expect(result, tBreedModel);
    });
  });
}
