import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_and_server_error/app_error.dart';

part 'result.freezed.dart';

class RequestStateNotifier<T> extends StateNotifier<RequestState<T>> {
  RequestStateNotifier() : super(const RequestState.idle());

  Future<RequestState<T>> makeRequest(Future<T> Function() function) async {
    try {
      state = RequestState<T>.loading();
      final response = await function();
      final newState = RequestState<T>.success(response);
      if (mounted) {
        state = newState;
      }
      return newState;
    } on Exception catch (e) {
      if (e is DioError) {}
      final newState = RequestState<T>.error(AppError(e));
      if (mounted) {
        state = newState;
      }
      return newState;
    }
  }

  Future<RequestState<T>> fetchNextPage(Future<T> Function() function) async {
    try {
      // state = RequestState<T>.loading();
      final response = await function();
      final currentData = ((getSuccessData() ?? []) as List<dynamic>);
      final newItems = currentData + (response as List<dynamic>) as T;
      final newState = RequestState<T>.success(newItems);
      if (mounted) {
        state = newState;
      }
      return newState;
    } on Exception catch (e) {
      if (e is DioError) {}
      final newState = RequestState<T>.error(AppError(e));
      if (mounted) {
        state = newState;
      }
      return newState;
    }
  }

  String getErrorMessage(Exception e) {
    bool isDioError = e is DioError;
    if (isDioError) {
      if ((e.type == DioErrorType.unknown &&
              e.error != null &&
              e.error is SocketException) ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectionTimeout) {
        return 'Unable to connect, Check your internet connection';
      }
      if ((e.response?.statusCode == 403) ||
          (e.response == null && e.type == DioErrorType.unknown)) {
        return '';
      }
    }

    return AppError(e).serverError?.message ?? 'An error occurred';
  }

  void changeStateToIdle() {
    state = RequestState<T>.idle();
  }

  dynamic getSuccessData() {
    return state.when(
        idle: () {},
        loading: () {},
        success: (data) => data,
        error: (error) {});
  }

  void updateStateData(dynamic data) {
    state = RequestState<T>.success(data);
  }
}

@freezed
class RequestState<T> with _$RequestState<T> {
  const factory RequestState.idle() = Idle<T>;

  const factory RequestState.loading() = Loading<T>;

  const factory RequestState.success(T value) = Success<T>;

  const factory RequestState.error(AppError error) = Failure<T>;
}
