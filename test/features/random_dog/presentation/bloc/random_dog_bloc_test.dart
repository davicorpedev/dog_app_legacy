import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/random_dog/domain/usecases/get_random_dog.dart';
import 'package:dog_app/features/random_dog/presentation/bloc/random_dog_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetRandomDog extends Mock implements GetRandomDog {}

void main() {
  MockGetRandomDog mockGetRandomDog;
  RandomDogBloc bloc;

  setUp(() {
    mockGetRandomDog = MockGetRandomDog();
    bloc = RandomDogBloc(getRandomDog: mockGetRandomDog);
  });

  test("initial state should be Initial", () {
    expect(bloc.state, Initial());
  });

  group("GetRandomDog", () {
    final tDog = Dog(
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
    );

    test("should get the data from the GetRandomDog use case", () async {
      when(mockGetRandomDog(any))
          .thenAnswer((realInvocation) async => Right(tDog));

      bloc.add(GetARandomDog());

      await untilCalled(mockGetRandomDog(any));

      verify(mockGetRandomDog(NoParams()));
    });

    test("should emit [Loading, Loaded] when data is gotten successfully", () {
      when(mockGetRandomDog(any))
          .thenAnswer((realInvocation) async => Right(tDog));

      final expected = [
        Initial(),
        Loading(),
        Loaded(dog: tDog),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetARandomDog());
    });

    test("should emit [Loading, Error] with an error when the data fails", () {
      when(mockGetRandomDog(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final expected = [
        Initial(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetARandomDog());
    });
  });
}
