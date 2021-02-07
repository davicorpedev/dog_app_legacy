import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/features/dog/domain/repositories/dog_repository.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/random_dog/domain/usecases/get_random_dog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  GetRandomDog useCase;
  MockDogRepository mockDogRepository;

  setUp(() {
    mockDogRepository = MockDogRepository();
    useCase = GetRandomDog(repository: mockDogRepository);
  });

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

  test("should return a random dog", () async {
    when(mockDogRepository.getRandomDog())
        .thenAnswer((realInvocation) async => Right(tDog));

    final result = await useCase(NoParams());

    expect(result, Right(tDog));
    verify(mockDogRepository.getRandomDog());
    verifyNoMoreInteractions(mockDogRepository);
  });
}
