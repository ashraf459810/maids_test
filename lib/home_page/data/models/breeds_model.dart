import 'dart:convert';

import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';

BreedsModel breedsModelFromJson(String str) =>
    BreedsModel.fromJson(json.decode(str));

class BreedsModel extends BreedsEntity {
  const BreedsModel(
      {required String status, required Map<String, List<String>> breeds})
      : super(status: status, breeds: breeds);

  factory BreedsModel.fromJson(Map<String, dynamic> json) => BreedsModel(
        breeds: Map.from(json["message"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
      );
}
