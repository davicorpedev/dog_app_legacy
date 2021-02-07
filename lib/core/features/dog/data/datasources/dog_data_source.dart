import 'dart:convert';

import 'package:dog_app/core/config/server_config.dart';
import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/core/features/dog/data/models/dog_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class DogDataSource {
  Future<List<DogModel>> getDogsByBreed(int breedId);

  Future<DogModel> getRandomDog();
}

class DogDataSourceImpl implements DogDataSource {
  final http.Client client;

  DogDataSourceImpl({@required this.client});

  @override
  Future<List<DogModel>> getDogsByBreed(int breedId) async {
    final response = await client.get(
      "$URL/images/search?limit=30&breed_id=$breedId",
      headers: {"x-api-key": API_KEY},
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return body.map<DogModel>((v) => DogModel.fromJson(v)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DogModel> getRandomDog() async {
    final response = await client.get(
      "$URL/images/search",
      headers: {"x-api-key": API_KEY},
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return DogModel.fromJson(body.first);
    } else {
      throw ServerException();
    }
  }
}
