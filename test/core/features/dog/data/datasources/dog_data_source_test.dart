
import 'package:dog_app/core/config/server_config.dart';
import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/core/features/dog/data/datasources/dog_data_source.dart';
import 'package:dog_app/core/features/dog/data/models/dog_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';



class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  DogDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = DogDataSourceImpl(client: mockHttpClient);
  });

  group("getDogsByBreed", () {
    final tBreedId = 1;

    final tDogModelList = [
      DogModel(
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
      ),
    ];

    test("should perform a GET request with a x-api-key in header", () async {
      when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("dog_list.json"), 200));

      dataSource.getDogsByBreed(tBreedId);

      verify(
        mockHttpClient.get(
          "$URL/images/search?limit=30&breed_id=$tBreedId",
          headers: {"x-api-key": API_KEY},
        ),
      );
    });

    test("should return a list of Dog when the request is 200", () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async =>
              http.Response(fixture("dog_list.json"), 200));

      final result = await dataSource.getDogsByBreed(tBreedId);

      expect(result, tDogModelList);
    });

    test("should throw ServerException when the request is unsuccessful",
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async => http.Response("Something went wrong", 404));

      final call = dataSource.getDogsByBreed;

      expect(() => call(tBreedId), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group("getRandomDog", () {
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

    test("should perform a GET request with a x-api-key in header", () async {
      when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (realInvocation) async => http.Response(fixture("dog.json"), 200));

      dataSource.getRandomDog();

      verify(
        mockHttpClient.get(
          "$URL/images/search",
          headers: {"x-api-key": API_KEY},
        ),
      );
    });

    test("should return a list of Dog when the request is 200", () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async => http.Response(fixture("dog.json"), 200));

      final result = await dataSource.getRandomDog();

      expect(result, tDogModel);
    });

    test("should throw ServerException when the request is unsuccessful",
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (realInvocation) async => http.Response("Something went wrong", 404));

      final call = dataSource.getRandomDog;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
