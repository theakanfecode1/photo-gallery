
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/repository/photo_repository.dart';
import 'package:photo_gallery/res/components/loading_indicator.dart';
import 'package:photo_gallery/view/components/photo_grid_item.dart';
import 'package:photo_gallery/view_model/photo_view_model.dart';

// Custom HttpOverrides to handle HTTPS requests
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Fake implementation of PhotoRepository for testing
class FakeRepository implements PhotoRepository {
  @override
  Future<List<Photo>> getPhotos({required int pageNum}) async {
    // Return a list of fake photos for testing
    return [
      Photo(
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
          name: 'User Name',
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
      ),
      Photo(
        id: 'photo_id',
        title: 'Photo Title',
        slug: 'photo_slug',
        createdAt: '2023-06-08',
        updatedAt: '2023-06-08',
        blurHash: 'blur_hash_value',
        description: 'A man walking',
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
          name: 'User Name',
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
      )
    ];  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Renders grid items with description',
          (WidgetTester tester) async {
        // Run the test within the custom HttpOverrides
        HttpOverrides.runZoned(
              () async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  // Override the photoRepositoryProvider with FakeRepository
                  photoRepositoryProvider.overrideWith((ref) {
                    return FakeRepository();
                  })
                ],
                child: MaterialApp(
                  home: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      // Watch the photoViewModelStateNotifier
                      final photoVM =
                      ref.watch(photoViewModelStateNotifierProvider);

                      // Call getPhotos after the frame has been rendered
                      TestWidgetsFlutterBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(photoViewModelStateNotifierProvider.notifier)
                            .getPhotos(pageNum: 1);
                      });

                      // Render the UI based on the state of photoVM
                      return photoVM.when(
                          idle: () => const LoadingIndicator(),
                          loading: () => const Center(child: LoadingIndicator()),
                          success: (data) => GridView.builder(
                            // GridView properties
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
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
                          error: (error) => Container());
                    },
                  ),
                ),
              ),
            );

            // Assert that grid is initially loading
            expect(find.byType(LoadingIndicator), findsOneWidget);

            // Re-render.
            await tester.pump();

            // No longer loading
            expect(find.byType(LoadingIndicator), findsNothing);


            // Assert that the grid items with descriptions are rendered
            expect(find.text('A phone store'), findsOneWidget);
            expect(find.text('A man walking'), findsOneWidget);
          },
          createHttpClient: (SecurityContext? context) {
            // Create a custom HttpClient with the overridden HttpOverrides
            return MockHttpOverrides().createHttpClient(context);
          },
        );
      });
}
