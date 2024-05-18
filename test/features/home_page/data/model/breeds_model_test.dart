import 'package:maids_test/home_page/data/models/breeds_model.dart';
import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const breedsModel = BreedsModel(
    status: "success",
    breeds: {
      "breed1": ["sub1", "sub2"],
      "breed2": ["sub3", "sub4"],
      // Add more breeds as needed
    },
  );

  test(
    'should be a subclass of Breed entity',
    () async {
      // assert
      expect(breedsModel, isA<BreedsEntity>());
    },
  );

  test(
    'should return a valid model when call breedsModelFromJson function',
    () async {
      // arrange
      final breeds =
          await rootBundle.loadString("test/breed_model/breeds.json");
      // act
      final result = breedsModelFromJson((breeds));
      // assert
      expect(result, isA<BreedsModel>());
    },
  );
}
