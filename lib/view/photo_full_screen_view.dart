import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/res/components/loading_indicator.dart';
import 'package:photo_gallery/res/style/app_colors.dart';
import 'package:photo_gallery/utils/cache_manager.dart';
import 'package:photo_gallery/view/components/photo_details.dart';
import 'package:photo_view/photo_view.dart';

class PhotoFullScreenView extends StatelessWidget {
  final Photo photo;

  const PhotoFullScreenView({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.black.withOpacity(0.4),
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        body: Stack(
          children: [
            Container(
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height,
                ),
                child: PhotoView(
                  backgroundDecoration: const BoxDecoration(
                    color: AppColors.black
                  ),
                  imageProvider: CachedNetworkImageProvider(photo.urls.regular,
                      cacheManager: CustomCacheManager.instance),
                  basePosition: Alignment.center,
                  loadingBuilder: (context, event) {
                    if (event == null) {
                      return const Center(child: LoadingIndicator());
                    }
                    final value = event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ??
                            event.cumulativeBytesLoaded);
                    return Center(
                      child: LoadingIndicator(value: value),
                    );
                  },
                  filterQuality: FilterQuality.none,
                )
                ),
            Positioned(
              left: 20,
              bottom: 10,
              right: 10,
              child: PhotoDetails(photo: photo),
            )
          ],
        ));
  }
}
