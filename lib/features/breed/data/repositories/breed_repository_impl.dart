import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/network/network_info.dart';
import 'package:dog_app/features/breed/data/datasources/breed_data_source.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dog_app/features/breed/domain/repositories/breed_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class BreedRepositoryImpl implements BreedRepository {
  final BreedDataSource dataSource;
  final NetworkInfo networkInfo;

  BreedRepositoryImpl({@required this.dataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, List<Breed>>> getBreeds() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getBreeds();

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
