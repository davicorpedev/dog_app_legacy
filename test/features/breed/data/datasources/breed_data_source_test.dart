import 'package:dog_app/core/config/server_config.dart';
import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/features/breed/data/datasources/breed_data_source.dart';
import 'package:dog_app/features/breed/data/models/breed_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  BreedDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = BreedDataSourceImpl(client: mockHttpClient);
  });

  group("getBreeds", () {
    final tBreedModelList = [
      BreedModel(
        id: 1,
        name: "test",
        temperament: "test",
        lifeSpan: "test",
        origin: "test",
        image: "test",
      )
    ];

    test("should perform a GET request with an API KEY in header", () {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("breed_list.json"), 200));

      dataSource.getBreeds();

      verify(mockHttpClient.get(
        "$URL/breeds",
        headers: {"x-api-key": API_KEY},
      ));
    });

    test("should return a list of Breed when the request is successful",
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("breed_list.json"), 200));

      final result = await dataSource.getBreeds();

      expect(result, equals(tBreedModelList));
    });

    test("should throw a ServerException when the response fails", () {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async => http.Response("Something went wrong", 404));

      final call = dataSource.getBreeds;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
