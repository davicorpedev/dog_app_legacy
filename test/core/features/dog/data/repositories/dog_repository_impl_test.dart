import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/data/datasources/dog_data_source.dart';
import 'package:dog_app/core/features/dog/data/models/dog_model.dart';
import 'package:dog_app/core/features/dog/data/repositories/dog_repository_impl.dart';
import 'package:dog_app/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDogDataSource extends Mock implements DogDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockDogDataSource mockDogDataSource;
  MockNetworkInfo mockNetworkInfo;
  DogRepositoryImpl repository;

  setUp(() {
    mockDogDataSource = MockDogDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DogRepositoryImpl(
      dataSource: mockDogDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

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

    final tDogList = tDogModelList;

    runTestsOnline(() {
      test("should check if the device is online", () {
        repository.getDogsByBreed(tBreedId);
        verify(mockNetworkInfo.isConnected);
      });

      test("should return data when the call is successful", () async {
        when(mockDogDataSource.getDogsByBreed(any))
            .thenAnswer((realInvocation) async => tDogModelList);

        final result = await repository.getDogsByBreed(tBreedId);

        verify(mockDogDataSource.getDogsByBreed(any));
        expect(result, Right(tDogList));
      });

      test("should return a ServerFailure if the request is unsuccessful",
          () async {
        when(mockDogDataSource.getDogsByBreed(any))
            .thenThrow(ServerException());

        final result = await repository.getDogsByBreed(tBreedId);

        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test("should return a NetworkFailure if the user has no connection",
          () async {
        final result = await repository.getDogsByBreed(tBreedId);

        verifyNever(mockDogDataSource.getDogsByBreed(any));
        expect(result, Left(NetworkFailure()));
      });
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

    final tDog = tDogModel;

    runTestsOnline(() {
      test("should check is the device is online", () {
        repository.getRandomDog();
        verify(mockNetworkInfo.isConnected);
      });

      test("should return a random Dog when the call is successful", () async {
        when(mockDogDataSource.getRandomDog())
            .thenAnswer((realInvocation) async => tDogModel);

        final result = await repository.getRandomDog();

        verify(mockDogDataSource.getRandomDog());
        expect(result, Right(tDog));
      });

      test("should return a ServerFailure when the request is unsuccessful",
          () async {
        when(mockDogDataSource.getRandomDog()).thenThrow(ServerException());

        final result = await repository.getRandomDog();

        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test("should return a NetworkFailure when the user has no connection",
          () async {
        final result = await repository.getRandomDog();

        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
