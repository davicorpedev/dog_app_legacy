import 'package:dog_app/core/entities/breed_base.dart';
import 'package:flutter/material.dart';

class BreedInfo extends StatelessWidget {
  final BreedBase breed;

  const BreedInfo({Key key, this.breed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Breed Info",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              "Name: ${breed.name}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 8),
            Text(
              "Origin: ${breed.origin ?? ""}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 8),
            Text(
              "Temperament: ${breed.temperament}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 8),
            Text(
              "LifeSpan: ${breed.lifeSpan}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
