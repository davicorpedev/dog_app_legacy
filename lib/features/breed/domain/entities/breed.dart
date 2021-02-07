import 'package:dog_app/core/entities/breed_base.dart';
import 'package:meta/meta.dart';

class Breed extends BreedBase {
  final String image;

  Breed({
    @required this.image,
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

  @override
  List<Object> get props => [id, name, temperament, lifeSpan, origin, image];
}
