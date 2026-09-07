import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org/v2',
          queryParameters: {
            'apiKey': '1f2e1381f5b34fbb9a9f460b80922ff0',
          },
        ),
      );
}