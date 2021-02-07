import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:meta/meta.dart';

class DogModel extends Dog {
  DogModel({
    @required String id,
    @required String url,
    @required List<DogBreed> breeds,
  }) : super(id: id, url: url, breeds: breeds);

  factory DogModel.fromJson(Map<String, dynamic> json) {
    return DogModel(
      id: json["id"],
      url: json["url"],
      breeds: json["breeds"]
          .map<DogBreedModel>((v) => DogBreedModel.fromJson(v))
          .toList(),
    );
  }
}

class DogBreedModel extends DogBreed {
  DogBreedModel({
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

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
    return DogBreedModel(
      id: json["id"],
      name: json["name"],
      temperament: json["temperament"],
      lifeSpan: json["life_span"],
      origin: json["origin"],
    );
  }
}
