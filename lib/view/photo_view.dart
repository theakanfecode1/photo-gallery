import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/res/style/app_colors.dart';
import 'package:photo_gallery/res/style/app_text_styles.dart';
import 'package:photo_gallery/utils/cache_manager.dart';
import 'package:photo_gallery/utils/string_ext.dart';
import 'package:photo_gallery/view/components/photo_details.dart';

class PhotoView extends StatelessWidget {
  final Photo photo;

  const PhotoView({Key? key, required this.photo}) : super(key: key);

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
              child: CachedNetworkImage(
                imageUrl: photo.urls.regular,
                fit: BoxFit.contain,
                cacheManager: CustomCacheManager.instance,
              ),
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

