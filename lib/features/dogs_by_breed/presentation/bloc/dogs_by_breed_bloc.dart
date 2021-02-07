import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/features/dogs_by_breed/domain/usecases/get_dogs_by_breed.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dogs_by_breed_event.dart';
part 'dogs_by_breed_state.dart';

class DogsByBreedBloc extends Bloc<DogsByBreedEvent, DogsByBreedState> {
  final GetDogsByBreed getDogsByBreed;

  DogsByBreedBloc({@required this.getDogsByBreed}) : super(Empty());

  @override
  Stream<DogsByBreedState> mapEventToState(
    DogsByBreedEvent event,
  ) async* {
    if (event is GetAllDogsByBreed) {
      yield Loading();
      final result = await getDogsByBreed(Params(breedId: event.breedId));

      yield* result.fold(
        (failure) async* {
          yield Error(message: mapFailureToMessage(failure));
        },
        (dogs) async* {
          yield Loaded(dogs: dogs);
        },
      );
    }
  }
}
