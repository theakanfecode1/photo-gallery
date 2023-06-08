import 'package:photo_gallery/api_key.dart';
import 'package:photo_gallery/core/network/services/app_dio.dart';
import 'package:photo_gallery/models/photo.dart';

class PhotoDataSource {
  static Future<List<Photo>> getPhotos({required int pageNum}) async {
    final response = await AppDio.dio.get('photos',
        queryParameters: {'client_id':unsplashApiKey,'per_page': 10, 'page': pageNum});
    return (response.data as List<dynamic>)
        .map((data) => Photo.fromJson(data))
        .toList(growable: true);
  }
}
