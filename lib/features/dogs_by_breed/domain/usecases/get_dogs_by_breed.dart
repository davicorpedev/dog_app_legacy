import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/features/dog/domain/repositories/dog_repository.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetDogsByBreed implements UseCase<List<Dog>, Params> {
  final DogRepository repository;

  GetDogsByBreed({@required this.repository});

  @override
  Future<Either<Failure, List<Dog>>> call(Params params) async {
    return await repository.getDogsByBreed(params.breedId);
  }
}

class Params extends Equatable {
  final int breedId;

  Params({@required this.breedId});

  @override
  List<Object> get props => [breedId];
}
