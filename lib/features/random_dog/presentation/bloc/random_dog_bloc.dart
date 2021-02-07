import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/random_dog/domain/usecases/get_random_dog.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'random_dog_event.dart';
part 'random_dog_state.dart';

class RandomDogBloc extends Bloc<RandomDogEvent, RandomDogState> {
  final GetRandomDog getRandomDog;

  RandomDogBloc({@required this.getRandomDog}) : super(Initial());

  @override
  Stream<RandomDogState> mapEventToState(
    RandomDogEvent event,
  ) async* {
    if (event is GetARandomDog) {
      yield Loading();
      final result = await getRandomDog(NoParams());

      yield* result.fold(
        (failure) async* {
          yield Error(message: mapFailureToMessage(failure));
        },
        (dog) async* {
          yield Loaded(dog: dog);
        },
      );
    }
  }
}
