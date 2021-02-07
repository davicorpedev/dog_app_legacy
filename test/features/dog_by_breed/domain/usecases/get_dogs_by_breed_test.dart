
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/features/dog/domain/repositories/dog_repository.dart';
import 'package:dog_app/features/dogs_by_breed/domain/usecases/get_dogs_by_breed.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  MockDogRepository mockDogRepository;
  GetDogsByBreed useCase;

  setUp(() {
    mockDogRepository = MockDogRepository();
    useCase = GetDogsByBreed(repository: mockDogRepository);
  });

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

  test("should return a list of dogs", () async {
    when(mockDogRepository.getDogsByBreed(any))
        .thenAnswer((realInvocation) async => Right(tDogList));

    final result = await useCase(Params(breedId: tBreedId));

    expect(result, Right(tDogList));
    verify(mockDogRepository.getDogsByBreed(tBreedId));
    verifyNoMoreInteractions(mockDogRepository);
  });
}
