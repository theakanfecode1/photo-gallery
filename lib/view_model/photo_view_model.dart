import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery/core/network/services/result.dart';
import 'package:photo_gallery/repository/photo_repository.dart';

final photoViewModelStateNotifierProvider =
    StateNotifierProvider<PhotoViewModel, RequestState>(
        (ref) => PhotoViewModel(ref.read(photoRepositoryProvider)));

class PhotoViewModel extends RequestStateNotifier<void> {
  final PhotoRepository _photoRepository;

  PhotoViewModel(this._photoRepository);

  Future<void> getPhotos({required int pageNum}) =>
      makeRequest(() => _photoRepository.getPhotos(pageNum: pageNum));

  Future<void> getPaginatedPhotos({required int pageNum}) =>
      fetchNextPage(() => _photoRepository.getPhotos(pageNum: pageNum));
}
