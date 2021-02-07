import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dog_app/features/breed/domain/usecases/get_breeds.dart';
import 'package:dog_app/features/breed/presentation/bloc/breed_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetBreeds extends Mock implements GetBreeds {}

void main() {
  MockGetBreeds mockGetBreeds;
  BreedBloc bloc;

  setUp(() {
    mockGetBreeds = MockGetBreeds();
    bloc = BreedBloc(getBreeds: mockGetBreeds);
  });

  test("initial state should be Empty", () {
    expect(bloc.state, Empty());
  });

  group("GetBreeds", () {
    final tBreedList = [
      Breed(
        image: "test",
        id: 1,
        name: "test",
        temperament: "test",
        lifeSpan: "test",
        origin: "test",
      ),
    ];

    test("should get the data from the GetBreeds use case", () async {
      when(mockGetBreeds(any))
          .thenAnswer((realInvocation) async => Right(tBreedList));

      bloc.add(GetAllBreeds());

      await untilCalled(mockGetBreeds(any));

      verify(mockGetBreeds(NoParams()));
    });

    test("should emit [Loading, Loaded] when data is gotten successfully", () {
      when(mockGetBreeds(any))
          .thenAnswer((realInvocation) async => Right(tBreedList));

      final expected = [
        Empty(),
        Loading(),
        Loaded(breeds: tBreedList),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetAllBreeds());
    });

    test("should emit [Loading, Error] with an error when the data fails", () {
      when(mockGetBreeds(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetAllBreeds());
    });
  });
}
