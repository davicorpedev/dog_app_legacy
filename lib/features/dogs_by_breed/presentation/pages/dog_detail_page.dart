import 'package:dog_app/core/features/dog/domain/entities/dog.dart';
import 'package:dog_app/core/features/download_image/presentation/widgets/download_image_icon_button.dart';
import 'package:flutter/material.dart';

class DogDetailPage extends StatelessWidget {
  final Dog dog;

  const DogDetailPage({Key key, this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DownloadImageIconButton(dog.url),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Hero(
            tag: dog.id,
            child: Image.network(dog.url),
          ),
        ),
      ),
    );
  }
}
