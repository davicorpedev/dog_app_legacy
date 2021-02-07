import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/features/dogs_by_breed/presentation/pages/dog_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DogGrid extends StatelessWidget {
  final List<Dog> dogs;

  const DogGrid({Key key, this.dogs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      itemCount: dogs.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Dog dog = dogs[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DogDetailPage(dog: dog)),
            );
          },
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Hero(
                tag: dog.id,
                child: new Image.network(dog.url),
              ),
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
    );
  }
}
