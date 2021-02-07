import 'package:dog_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class UrlDownloader {
  Future<Either<Failure, bool>> download(String url) async {
    try {
      await ImageDownloader.downloadImage(url);

      return Right(true);
    } on PlatformException {
      return Left(InvalidUrlDownloader());
    }
  }
}

class InvalidUrlDownloader extends Failure {}
