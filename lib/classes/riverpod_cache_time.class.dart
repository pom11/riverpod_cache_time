import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodCacheTime<T extends AutoDisposeFutureProviderRef> {
  final int cacheMaxSecond;
  final T ref;
  final KeepAliveLink link;
  Timer? timer;
  CancelToken? cancelToken;
  DateTime firstTime = DateTime.now();

  RiverpodCacheTime({
    required this.cacheMaxSecond,
    required this.ref,
    required this.link,
    @Deprecated('It will be removed in the next major version update.') this.cancelToken,
  }) {
    _init();
  }

  _init() {
    _tryReTimer();

    ref.onResume(() {
      if (firstTime.year == 2022) {
        firstTime = DateTime.now();
      }
      _checkCache(
        closeAndCanceled: () {
          _cancelTimer();
        },
        nothing: () {
          _tryReTimer();
        },
      );
    });

    ref.onAddListener(() {
      if (firstTime.year == 2022) {
        firstTime = DateTime.now();
      }
      _checkCache(
        closeAndCanceled: () {
          _cancelTimer();
        },
        nothing: () {
          _tryReTimer();
        },
      );
    });
  }

  _checkCache({Function? closeAndCanceled, Function? nothing}) {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(firstTime);
    if (cacheMaxSecond < difference.inSeconds) {
      firstTime = firstTime.copyWith(year: 2022);
      link.close();
      if (cancelToken != null) {
        if (cancelToken?.isCancelled == false) {
          cancelToken?.cancel();
        }
      }
      if (closeAndCanceled != null) {
        closeAndCanceled();
      }
    } else {
      if (nothing != null) {
        nothing();
      }
    }
  }

  _cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  _tryReTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkCache(
        closeAndCanceled: () {
          _cancelTimer();
        },
        nothing: () {
          _tryReTimer();
        },
      );
    });
  }
}
