import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_gallery/core/network/services/my_http_overrides.dart';
import 'package:photo_gallery/res/style/app_colors.dart';
import 'package:photo_gallery/view/photos_grid_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Photo Gallery',
        theme: ThemeData(
            primaryColor: AppColors.black,
            fontFamily: ('Lato' ),
            colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: AppColors.black)),
        home: const PhotosGridView(),
      ),
    );
  }
}
