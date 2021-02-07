import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/data/datasources/dog_data_source.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/features/dog/domain/repositories/dog_repository.dart';
import 'package:dog_app/core/network/network_info.dart';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class DogRepositoryImpl implements DogRepository {
  final DogDataSource dataSource;
  final NetworkInfo networkInfo;

  DogRepositoryImpl({@required this.dataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, List<Dog>>> getDogsByBreed(int breedId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getDogsByBreed(breedId);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Dog>> getRandomDog() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getRandomDog();

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
