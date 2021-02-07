import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/network/network_info.dart';
import 'package:dog_app/features/breed/data/datasources/breed_data_source.dart';
import 'package:dog_app/features/breed/data/models/breed_model.dart';
import 'package:dog_app/features/breed/data/repositories/breed_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBreedDataSource extends Mock implements BreedDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockNetworkInfo mockNetworkInfo;
  MockBreedDataSource mockBreedDataSource;
  BreedRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockBreedDataSource = MockBreedDataSource();
    repository = BreedRepositoryImpl(
      dataSource: mockBreedDataSource,
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

  group("getBreeds", () {
    final tBreedModelList = [
      BreedModel(
        id: 1,
        name: "test",
        temperament: "test",
        lifeSpan: "test",
        origin: "test",
        image: "test",
      ),
    ];

    final tBreedList = tBreedModelList;

    runTestsOnline(() {
      test("should check if the device is online", () {
        repository.getBreeds();
        verify(mockNetworkInfo.isConnected);
      });

      test("should return data when the call is successful", () async {
        when(mockBreedDataSource.getBreeds())
            .thenAnswer((realInvocation) async => tBreedModelList);

        final result = await repository.getBreeds();

        verify(mockBreedDataSource.getBreeds());
        expect(result, equals(Right(tBreedList)));
      });

      test("should return ServerFailure when the request is unsuccessful",
          () async {
        when(mockBreedDataSource.getBreeds()).thenThrow(ServerException());

        final result = await repository.getBreeds();

        verify(mockBreedDataSource.getBreeds());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("should return NetworkFailure when the user has no connection",
          () async {
        final result = await repository.getBreeds();

        verifyNever(mockBreedDataSource.getBreeds());
        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });
}
