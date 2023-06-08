import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/res/style/app_text_styles.dart';
import 'package:photo_gallery/utils/cache_manager.dart';
import 'package:photo_gallery/utils/string_ext.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: photo.user.profileImage.small,
                  cacheManager: CustomCacheManager.instance,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(photo.user.name,style: AppTextStyles.kH3Lightx2,),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(photo.description.isNotEmpty
              ? photo.description.capitalizeFirst
              : photo.altDescription.capitalizeFirst,style: AppTextStyles.kB1,textAlign: TextAlign.left,),
          const SizedBox(
            height: 10,
          ),
          if(photo.user.portfolioUrl.isNotEmpty)Text('Portfolio URL: ${photo.user.portfolioUrl}',style: AppTextStyles.kB1,textAlign: TextAlign.left,),
        ],
      ),
    );
  }
}
