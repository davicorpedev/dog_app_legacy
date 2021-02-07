import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/features/dogs_by_breed/domain/usecases/get_dogs_by_breed.dart';
import 'package:dog_app/features/dogs_by_breed/presentation/bloc/dogs_by_breed_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetDogsByBreed extends Mock implements GetDogsByBreed {}

void main() {
  MockGetDogsByBreed mockGetDogsByBreed;
  DogsByBreedBloc bloc;

  setUp(() {
    mockGetDogsByBreed = MockGetDogsByBreed();
    bloc = DogsByBreedBloc(getDogsByBreed: mockGetDogsByBreed);
  });

  test("initial state should be Empty", () {
    expect(bloc.state, Empty());
  });

  group("GetDogsByBreed", () {
    final tBreedId = 1;

    final tDogList = [
      Dog(
        id: "test",
        url: "test",
        breeds: [
          DogBreed(
            id: 1,
            name: "test",
            temperament: "test",
            lifeSpan: "test",
            origin: "test",
          ),
        ],
      ),
    ];

    test("should get the data from the GetDogsByBreed use case", () async {
      when(mockGetDogsByBreed(any))
          .thenAnswer((realInvocation) async => Right(tDogList));

      bloc.add(GetAllDogsByBreed(breedId: tBreedId));

      await untilCalled(mockGetDogsByBreed(any));

      verify(mockGetDogsByBreed(Params(breedId: tBreedId)));
    });

    test("should emit [Loading, Loaded] when data is gotten successfully", () {
      when(mockGetDogsByBreed(any))
          .thenAnswer((realInvocation) async => Right(tDogList));

      final expected = [
        Empty(),
        Loading(),
        Loaded(dogs: tDogList),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetAllDogsByBreed(breedId: tBreedId));
    });

    test("should emit [Loading, Error] with an error when the data fails", () {
      when(mockGetDogsByBreed(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetAllDogsByBreed(breedId: tBreedId));
    });
  });
}
