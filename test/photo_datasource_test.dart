import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/core/network/services/app_dio.dart';
import 'package:photo_gallery/datasource/photo_datasource.dart';
import 'package:photo_gallery/models/photo.dart';

void main() {
  group('Photo datasource API test', () {
    tearDown(() {
      // Clean up any resources used in the test
      AppDio.dio.close(); // Close the AppDio instance after the test
    });

    test('getPhotos returns a list of photos', () async {
      // Make the API request and retrieve the response
      final List<Photo> photos = await PhotoDataSource.getPhotos(pageNum: 1);

      // Verify that the response is not null and contains valid data
      expect(photos, isNotNull);
      expect(photos, isNotEmpty);

      // Verify the structure and properties of the returned Photo objects
      for (final photo in photos) {
        expect(photo.id, isNotNull);
        expect(photo.createdAt, isNotNull);
        expect(photo.updatedAt, isNotNull);
        expect(photo.description, isNotNull);
        expect(photo.altDescription, isNotNull);
        expect(photo.urls, isNotNull);
        expect(photo.user, isNotNull);
      }
    });

    test('getPhotos handles error', () async {
      // Arrange
      int pageNum = 1;

      // Close dio to simulate an error response
      AppDio.dio.close();

      // Act and Assert
      expect(
            () async => await PhotoDataSource.getPhotos(pageNum: pageNum),
        throwsA(isA<Exception>()),
      );
    });
  });
}
