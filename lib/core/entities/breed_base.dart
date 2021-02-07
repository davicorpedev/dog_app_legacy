import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BreedBase extends Equatable {
  final int id;
  final String name;
  final String temperament;
  final String lifeSpan;
  final String origin;

  BreedBase({
    @required this.id,
    @required this.name,
    @required this.temperament,
    @required this.lifeSpan,
    @required this.origin,
  });

  @override
  List<Object> get props => [id, name, temperament, lifeSpan, origin];
}
