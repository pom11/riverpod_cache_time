import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_cache_time/util/logger/logger.dart';
import 'package:riverpod_cache_time_example/provider_class/get_api_data.provider.dart';
// import 'package:riverpod_cache_time_example/provider/get_api_data.provider.dart';

import 'test_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final apiData = ref.watch(getApiDataProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            apiData.when(
              data: (data) {
                logger.d('###data $data');
                return Text(data);
              },
              error: (error, st) {
                logger.d('###error', error);
                return const Text('error!');
              },
              loading: () {
                logger.d('###loading...');
                return const Text('loading...');
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TestScreen()));
              },
              child: const Text('테스트 페이지로'),
            ),
          ],
        ),
      ),
    );
  }
}
