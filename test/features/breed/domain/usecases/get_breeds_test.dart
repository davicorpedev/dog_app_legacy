import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dog_app/features/breed/domain/repositories/breed_repository.dart';
import 'package:dog_app/features/breed/domain/usecases/get_breeds.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBreedRepository extends Mock implements BreedRepository {}

void main() {
  MockBreedRepository mockBreedRepository;
  GetBreeds useCase;

  setUp(() {
    mockBreedRepository = MockBreedRepository();
    useCase = GetBreeds(repository: mockBreedRepository);
  });

  final tBreedList = [
    Breed(
      id: 1,
      name: "test",
      temperament: "test",
      lifeSpan: "test",
      origin: "test",
      image:"test",
    ),
  ];

  test("should return a list of breeds", () async {
    when(mockBreedRepository.getBreeds())
        .thenAnswer((realInvocation) async => Right(tBreedList));

    final result = await useCase(NoParams());

    expect(result, Right(tBreedList));
    verify(mockBreedRepository.getBreeds());
    verifyNoMoreInteractions(mockBreedRepository);
  });
}
