import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dartz/dartz.dart';

abstract class BreedRepository {
  Future<Either<Failure, List<Breed>>> getBreeds();
}
