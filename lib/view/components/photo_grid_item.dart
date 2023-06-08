import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/res/style/app_colors.dart';
import 'package:photo_gallery/res/style/app_text_styles.dart';
import 'package:photo_gallery/utils/string_ext.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;
  const PhotoGridItem({Key? key,required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.blue),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl:
            photo.urls.thumb,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            memCacheWidth: 200,
          ),
          Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withOpacity(0.01),
                    AppColors.black.withOpacity(0.4),
                  ],
                  tileMode: TileMode.repeated,
                )
            ),
            child:  Padding(
              padding:const  EdgeInsets.only(left:8.0,bottom: 8.0),
              child: Text(
                photo.description.isNotEmpty ? photo.description.capitalizeFirst : photo.altDescription.capitalizeFirst,
                style: AppTextStyles.kH3Lightx2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
