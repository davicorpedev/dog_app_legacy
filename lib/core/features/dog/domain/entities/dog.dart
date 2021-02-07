import 'package:dog_app/core/entities/breed_base.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Dog extends Equatable {
  final String id;
  final String url;
  final List<DogBreed> breeds;

  Dog({@required this.id, @required this.url, @required this.breeds});

  @override
  List<Object> get props => [id, url, breeds];
}

class DogBreed extends BreedBase {
  DogBreed({
    @required int id,
    @required String name,
    @required String temperament,
    @required String lifeSpan,
    @required String origin,
  }) : super(
          id: id,
          name: name,
          temperament: temperament,
          lifeSpan: lifeSpan,
          origin: origin,
        );
}
