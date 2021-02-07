import 'package:bloc/bloc.dart';
import 'package:dog_app/core/util/url_downloader.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'download_image_state.dart';

class DownloadImageCubit extends Cubit<DownloadImageState> {
  final UrlDownloader downloader;

  DownloadImageCubit({@required this.downloader}) : super(Initial());

  Future<void> downloadImage(String url) async {
    emit(Loading());
    final result = await downloader.download(url);

    result.fold(
      (error) {
        emit(Error());
      },
      (isDownloaded) {
        emit(Loaded());
      },
    );
  }
}
