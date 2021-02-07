import 'package:dog_app/core/features/dog/data/datasources/dog_data_source.dart';
import 'package:dog_app/core/features/dog/data/repositories/dog_repository_impl.dart';
import 'package:dog_app/core/features/dog/domain/repositories/dog_repository.dart';
import 'package:dog_app/core/features/download_image/presentation/cubit/download_image_cubit.dart';
import 'package:dog_app/core/util/url_downloader.dart';
import 'package:dog_app/features/breed/data/datasources/breed_data_source.dart';
import 'package:dog_app/features/breed/data/repositories/breed_repository_impl.dart';
import 'package:dog_app/features/breed/domain/repositories/breed_repository.dart';
import 'package:dog_app/features/breed/domain/usecases/get_breeds.dart';
import 'package:dog_app/features/breed/presentation/bloc/breed_bloc.dart';
import 'package:dog_app/features/dogs_by_breed/domain/usecases/get_dogs_by_breed.dart';
import 'package:dog_app/features/dogs_by_breed/presentation/bloc/dogs_by_breed_bloc.dart';
import 'package:dog_app/features/random_dog/domain/usecases/get_random_dog.dart';
import 'package:dog_app/features/random_dog/presentation/bloc/random_dog_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Breed
  //Bloc
  sl.registerFactory(
    () => BreedBloc(
      getBreeds: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => GetBreeds(repository: sl()));

  //Repository
  sl.registerLazySingleton<BreedRepository>(
    () => BreedRepositoryImpl(
      dataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<BreedDataSource>(
    () => BreedDataSourceImpl(client: sl()),
  );

  /// Features - RandomDog
  //Bloc
  sl.registerFactory(
    () => RandomDogBloc(
      getRandomDog: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => GetRandomDog(repository: sl()));

  //Repository
  sl.registerLazySingleton<DogRepository>(
    () => DogRepositoryImpl(
      dataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DogDataSource>(
    () => DogDataSourceImpl(client: sl()),
  );

  /// Features - GetDogsByBreed
  //Bloc
  sl.registerFactory(
    () => DogsByBreedBloc(
      getDogsByBreed: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => GetDogsByBreed(repository: sl()));

  /// Core
  // Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //Util
  sl.registerLazySingleton<UrlDownloader>(() => UrlDownloader());

  //Features
  sl.registerFactory<DownloadImageCubit>(() => DownloadImageCubit(downloader: sl()));


  ///External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
