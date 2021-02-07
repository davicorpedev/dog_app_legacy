import 'dart:convert';

import 'package:dog_app/core/config/server_config.dart';
import 'package:dog_app/core/error/exceptions.dart';
import 'package:dog_app/features/breed/data/models/breed_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class BreedDataSource {
  Future<List<BreedModel>> getBreeds();
}

class BreedDataSourceImpl implements BreedDataSource {
  final http.Client client;

  BreedDataSourceImpl({@required this.client});

  @override
  Future<List<BreedModel>> getBreeds() async {
    final response = await client.get(
      "$URL/breeds",
      headers: {"x-api-key": API_KEY},
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return body.map<BreedModel>((v) => BreedModel.fromJson(v)).toList();
    } else {
      throw ServerException();
    }
  }
}
