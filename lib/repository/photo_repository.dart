import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery/datasource/photo_datasource.dart';
import 'package:photo_gallery/models/photo.dart';


final photoRepositoryProvider =
Provider<PhotoRepository>((ref) => PhotoRepository());

class PhotoRepository {

  Future<List<Photo>> getPhotos({required int pageNum}) {
    return PhotoDataSource.getPhotos(pageNum: pageNum);
  }
}
