import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:meta/meta.dart';
import 'package:dog_app/features/breed/domain/repositories/breed_repository.dart';
import 'package:dartz/dartz.dart';

class GetBreeds implements UseCase<List<Breed>, NoParams> {
  final BreedRepository repository;

  GetBreeds({@required this.repository});

  @override
  Future<Either<Failure, List<Breed>>> call(NoParams params) async {
    return await repository.getBreeds();
  }
}
