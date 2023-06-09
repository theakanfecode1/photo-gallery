import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/res/components/loading_indicator.dart';
import 'package:photo_gallery/res/style/app_colors.dart';
import 'package:photo_gallery/res/style/app_text_styles.dart';
import 'package:photo_gallery/view/components/photo_grid_item.dart';
import 'package:photo_gallery/view_model/photo_view_model.dart';

class PhotosGridView extends ConsumerStatefulWidget {
  const PhotosGridView({Key? key}) : super(key: key);

  @override
  ConsumerState<PhotosGridView> createState() => _PhotosViewState();
}

class _PhotosViewState extends ConsumerState<PhotosGridView> {
  int _page = 1;
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;
  ScrollController scrollController = ScrollController();

  void getPhotos() async {
    if (_isFirstLoadRunning) {
      await ref.read(photoViewModelStateNotifierProvider.notifier).getPhotos(
            pageNum: 1,
          );
      setState(() {
        _isFirstLoadRunning = false;
      });
    } else {
      if (!_isLoadMoreRunning &&
          (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent)) {
        setState(() {
          _isLoadMoreRunning = true;
        });
        _page += 1;
        await ref
            .read(photoViewModelStateNotifierProvider.notifier)
            .getPaginatedPhotos(
              pageNum: _page,
            );
        _isLoadMoreRunning = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, getPhotos);
    scrollController.addListener(getPhotos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final photosVm = ref.watch(photoViewModelStateNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.black,
        title: const Text(
          'Photo Gallery',
          style: AppTextStyles.kH2Light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: photosVm.when(
            idle: () => const Center(child: LoadingIndicator()),
            loading: () => const Center(child: LoadingIndicator()),
            success: (data) => GridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:
                        (MediaQuery.of(context).size.width / 2) / 200,
                  ),
                  itemBuilder: (context, index) => PhotoGridItem(
                    photo: data[index],
                  ),
                  itemCount: (data as List<Photo>).length,
                ),
            error: (error) => Center(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(photoViewModelStateNotifierProvider.notifier)
                          .getPhotos(pageNum: 1);
                      _page = 1;
                    },
                    child: const Text(
                      'Unable to load data.\n Tap to reload',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.kH3Lightx2,
                    ),
                  ),
                )),
      ),
    );
  }
}
