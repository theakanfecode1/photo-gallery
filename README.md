# Photo Gallery Application

Welcome to the Photo Gallery application! This application allows you to view and browse through a
collection of photos fetched from an API.

## Prerequisites

Before running the application, please make sure you have the following installed on your machine:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Installation Guide](https://dart.dev/get-dart)
- My local version (Flutter 3.7.12, Dart 2.19.6)

## Getting Started

To get started with the application, follow these steps:

1. Clone the repository to your local machine:
    - git clone https://github.com/theakanfecode1/photo_gallery.git

2. Navigate to the project directory:
    - cd photo_gallery

3. Install the dependencies:
    - flutter pub get

4. Run the application:
    - flutter run

This will launch the application on an available emulator or connected device.

## Running Tests

The application includes unit tests to ensure the functionality is working correctly. To execute the
tests, follow these steps:

1. Navigate to the project directory if you're not already there:
    - cd photo_gallery

2. Run the tests:
To separately run test for each test file
    - For photo_grid_view_test.dart: flutter test test/photo_grid_view_test.dart
    - For photo_full_screen_test.dart: flutter test test/photo_full_screen_test.dart
    - For photo_datasource_test.dart: flutter test test/photo_datasource_test.dart

To run test files all together
   -  flutter test test/photo_datasource_test.dart test/photo_full_screen_test.dart
      test/photo_grid_view_test.dart

This command will run all the unit tests and display the results in the console.

## Additional Configuration

If you encounter any issues running the application or the tests, you can try the following steps:

- Ensure you have a stable internet connection to fetch data from the API.
- Check that your Flutter and Dart SDK versions are compatible with the project. You can use the
  following commands to verify:
  flutter --version
  dart --version

- If you're running the tests and they fail due to network-related issues, make sure you have a
  stable internet connection and that the API server is accessible.

If you need any further assistance or have any questions, please feel free to reach out to me at
danielogundiranakanfe@gmail.com.

Enjoy browsing through the beautiful photo collection in the Photo Gallery application!

## PERFORMANCE OPTIMIZATIONS

1. Lazy Loading / Infinite Scrolling: Instead of loading all the data at once, lazy loading or
   infinite scrolling loaded data incrementally as the user scrolled. This reduced the initial load
   time and improved the performance of the application. It also reduced network bandwidth and
   memory consumption as only the necessary data was loaded. It led to faster page load times and
   better user experience.

2. Caching: To optimize performance and reduce unnecessary network requests, the application
   incorporates caching mechanisms. The `CachedNetworkImage` widget from the `cached_network_image`
   package is used to load and cache images from the network. The `CustomCacheManager` class
   provides a custom cache manager implementation to handle caching of the network images. This
   helps in minimizing data usage and improves the overall user experience by loading images faster
   on subsequent requests.

3. Optimized API Requests: The optimization of API requests involved reducing unnecessary data and
   optimizing the structure of the requests. This was achieved by utilizing query parameters (page
   and per_page) to fetch only the required data and avoiding the retrieval of large amounts of
   unnecessary data. By minimizing the amount of data transferred over the network, the performance
   of the application was improved.

4. Optimized Rendering: This was accomplished by utilizing efficient UI components such
   as `GridView.builder`, which only rendered the visible items on the screen. This approach avoided
   rendering all the data at once, resulting in reduced memory usage and improved rendering
   performance. Additionally, the use of `const` for widgets that have constant properties helped in
   optimizing rendering by reusing widget instances and skipping unnecessary rebuilds, leading to
   better performance, especially in scenarios with large or frequently changing widget trees.

5. Asynchronous Operations: Asynchronous operations, such as API requests, are handled using Future
   and async/await syntax. This allows for non-blocking execution and ensures a smooth user
   experience

Overall, the user experience was improved through enhanced load times, reduced network latency, and
the provision of a responsive and smooth UI, resulting in higher user satisfaction.

## ADDITIONAL INFORMATION ABOUT IMPLEMENTATION OR DESIGN CHOICES

The application was designed using the MVVM (Model-View-ViewModel) architecture pattern, combined
with the Riverpod state management library. This architecture promotes separation of concerns and
helps maintain a clear separation between the UI components (View), the data and business logic (
ViewModel), and the data models (Model).

Here are some key design choices and implementations in the application:

1. Riverpod State Management: Riverpod is a state management library that follows the Provider
   pattern. It allows for easy and efficient management of application state, providing a clean and
   scalable solution for handling state changes across different components. Riverpod was used to
   manage the state of the photo gallery, including fetching and displaying photos, handling loading
   and error states, and updating the UI as the state changes.

2. API Integration: The application integrates with an API to fetch the photo data.
   The `PhotoDataSource` class handles the API requests and responses using the Dio HTTP client
   library. The `getPhotos` method fetches a list of photos based on the provided page number. The
   received JSON response was then mapped to a list of `Photo` objects.

3. Pagination: The application implements pagination to efficiently load and display a large number
   of photos. The `getPhotos` method accepts a `pageNum` parameter, which was used to fetch the
   corresponding page of photos from the API. By fetching a limited number of photos per page, the
   application reduces the initial loading time and memory usage. As the user scrolls and reaches
   the end of the current page, the next page of photos is fetched dynamically, providing a smooth
   scrolling experience.

4. Caching: The application includes caching functionality to enhance performance and minimize
   unnecessary network requests. It utilizes the `CachedNetworkImage` widget from
   the `cached_network_image` package, which enables loading and caching of images from the network.
   To manage the caching process, a custom cache manager implementation called `CustomCacheManager`
   was employed. This caching mechanism effectively reduces data usage and enhances the user
   experience by ensuring faster image loading on subsequent requests.

5. Testing: Unit tests are included to verify the functionality and behavior of key components, such
   as the `PhotoDataSource`, `PhotosGridView`, `PhotoFullScreenView` classes and the ViewModel.
   Tests are written using the Flutter test framework and cover scenarios like fetching photos,
   handling errors, and verifying the structure and properties of the received data. The tests
   ensure that the application functions as expected and help in identifying and fixing issues
   during development.

These design choices and implementations provided a scalable, performant, and maintainable
application. The MVVM architecture with Riverpod enables a clear separation of concerns, making the
codebase more modular and testable. The pagination and caching mechanisms optimize the application's
performance by efficiently managing data loading and minimizing unnecessary network requests. The
inclusion of unit tests helps ensure the correctness of the implemented features and aids in
catching bugs early in the development process.



