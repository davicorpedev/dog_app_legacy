import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/features/dog/domain/repositories/dog_repository.dart';
import 'package:dog_app/core/usecases/usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetRandomDog implements UseCase<Dog, NoParams> {
  final DogRepository repository;

  GetRandomDog({@required this.repository});

  @override
  Future<Either<Failure, Dog>> call(NoParams params) async {
    return await repository.getRandomDog();
  }
}
