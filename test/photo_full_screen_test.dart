import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/view/components/photo_details.dart';
import 'package:photo_gallery/view/photo_full_screen_view.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  testWidgets('PhotoFullScreenView widget test', (WidgetTester tester) async {
    // Create a mock Photo object for testing
    final photo = Photo(
      id: 'photo_id',
      title: 'Photo Title',
      slug: 'photo_slug',
      createdAt: '2023-06-08',
      updatedAt: '2023-06-08',
      blurHash: 'blur_hash_value',
      description: 'A phone store',
      altDescription: 'Alternative description',
      urls: Urls(
        raw: 'raw_url',
        full: 'full_url',
        regular: 'regular_url',
        small: 'small_url',
        thumb: 'thumb_url',
        smallS3: 'small_s3_url',
      ),
      user: User(
        id: 'user_id',
        updatedAt: '2023-06-08',
        username: 'username',
        name: 'Daniel Ogundiran',
        firstName: 'First Name',
        lastName: 'Last Name',
        twitterUsername: 'twitter_username',
        portfolioUrl: 'portfolio_url',
        bio: 'User bio',
        profileImage: ProfileImage(
          small: 'small_image_url',
          medium: 'medium_image_url',
          large: 'large_image_url',
        ),
        location: 'User location',
        instagramUsername: 'instagram_username',
        totalCollections: 0,
        totalLikes: 0,
        totalPhotos: 0,
        acceptedTos: true,
        forHire: false,
        social: Social(
          instagramUsername: 'instagram_username',
          portfolioUrl: 'portfolio_url',
          twitterUsername: 'twitter_username',
          paypalEmail: 'paypal_email',
        ),
      ),
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(),
          child: PhotoFullScreenView(photo: photo),
        ),
      ),
    );
    // Verify that the widget tree is correctly rendered
    expect(find.text('Daniel Ogundiran'), findsOneWidget);
    expect(find.text('A phone store'), findsOneWidget);

    // Verify the presence of certain widgets or components
    expect(find.byType(PhotoView), findsOneWidget);
    expect(find.byType(PhotoDetails), findsOneWidget);
  });
}
