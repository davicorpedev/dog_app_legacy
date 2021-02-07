import 'package:dog_app/features/breed/domain/entities/breed.dart';
import 'package:dog_app/features/dogs_by_breed/presentation/pages/dogs_by_breed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BreedGrid extends StatelessWidget {
  final List<Breed> breeds;

  const BreedGrid({Key key, this.breeds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      itemCount: breeds.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Breed breed = breeds[index];

        return Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DogByBreedPage(breed: breed),
                ),
              );
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: new Image.network(breed.image),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    breed.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
    );
  }
}
