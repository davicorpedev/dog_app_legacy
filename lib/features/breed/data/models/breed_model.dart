import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:meta/meta.dart';

class BreedModel extends Breed {
  BreedModel({
    @required int id,
    @required String name,
    @required String temperament,
    @required String lifeSpan,
    @required String origin,
    @required String image,
  }) : super(
            id: id,
            name: name,
            temperament: temperament,
            lifeSpan: lifeSpan,
            origin: origin,
            image: image);

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json["id"],
      name: json["name"],
      temperament: json["temperament"],
      lifeSpan: json["life_span"],
      origin: json["origin"],
      image: json["image"]["url"],
    );
  }
}
