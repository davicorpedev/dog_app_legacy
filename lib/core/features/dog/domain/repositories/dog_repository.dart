import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dartz/dartz.dart';

abstract class DogRepository {
  Future<Either<Failure, List<Dog>>> getDogsByBreed(int breedId);

  Future<Either<Failure, Dog>> getRandomDog();
}
