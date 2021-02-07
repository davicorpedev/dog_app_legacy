import 'package:dog_app/core/features/download_image/presentation/cubit/download_image_cubit.dart';
import 'package:dog_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadImageIconButton extends StatefulWidget {
  final String url;

  DownloadImageIconButton(this.url);

  @override
  _DownloadImageIconButtonState createState() =>
      _DownloadImageIconButtonState();
}

class _DownloadImageIconButtonState extends State<DownloadImageIconButton> {
  DownloadImageCubit cubit = sl<DownloadImageCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadImageCubit, DownloadImageState>(
      cubit: cubit,
      listener: (context, state) {
        if (state is Loaded) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Image downloaded")),
          );
        } else if (state is Error) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Error")),
          );
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        }
        return IconButton(
          icon: Icon(Icons.file_download),
          onPressed: () {
            cubit.downloadImage(widget.url);
          },
        );
      },
    );
  }
}
