import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dog_app/core/error/failures.dart';
import 'package:dog_app/core/usecases/usecase.dart';
import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dog_app/features/breed/domain/usecases/get_breeds.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'breed_event.dart';
part 'breed_state.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  final GetBreeds getBreeds;

  BreedBloc({this.getBreeds}) : super(Empty());

  @override
  Stream<BreedState> mapEventToState(
    BreedEvent event,
  ) async* {
    if (event is GetAllBreeds) {
      yield Loading();
      final result = await getBreeds(NoParams());

      yield* result.fold(
        (failure) async* {
          yield Error(message: mapFailureToMessage(failure));
        },
        (breeds) async* {
          yield Loaded(breeds: breeds);
        },
      );
    }
  }
}
