// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/news_app/core/di/injection.dart' as _i401;
import 'package:news_app/news_app/core/router/app_router.dart' as _i312;
import 'package:news_app/news_app/core/services/secure_storage_service.dart'
    as _i256;
import 'package:news_app/news_app/core/services/storage_service.dart' as _i156;
import 'package:news_app/news_app/data/data_source/abstract/news_data_source.dart'
    as _i196;
import 'package:news_app/news_app/data/data_source/remote/news_data_source_impl.dart'
    as _i176;
import 'package:news_app/news_app/data/repositories/news_repository_impl.dart'
    as _i437;
import 'package:news_app/news_app/domain/repositories/news_repository.dart'
    as _i476;
import 'package:news_app/news_app/domain/usecases/get_top_headlines.dart'
    as _i144;
import 'package:news_app/news_app/domain/usecases/search_news.dart' as _i585;
import 'package:news_app/news_app/ui/providers/news_provider.dart' as _i269;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    final registerModule = _$RegisterModule();
    final secureStorageModule = _$SecureStorageModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i312.AppRouter>(() => _i312.AppRouter());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => secureStorageModule.secureStorage);
    gh.lazySingleton<_i156.StorageService>(
        () => _i156.StorageService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i196.NewsDataSource>(
        () => _i176.NewsDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i256.SecureStorageService>(
        () => _i256.SecureStorageService(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i476.NewsRepository>(() =>
        _i437.NewsRepositoryImpl(newsDataSource: gh<_i196.NewsDataSource>()));
    gh.factory<_i144.GetTopHeadlines>(
        () => _i144.GetTopHeadlines(gh<_i476.NewsRepository>()));
    gh.factory<_i585.SearchNews>(
        () => _i585.SearchNews(gh<_i476.NewsRepository>()));
    gh.factory<_i269.NewsProvider>(() => _i269.NewsProvider(
          getTopHeadlinesUseCase: gh<_i144.GetTopHeadlines>(),
          searchNewsUseCase: gh<_i585.SearchNews>(),
        ));
    return this;
  }
}

class _$StorageModule extends _i156.StorageModule {}

class _$RegisterModule extends _i401.RegisterModule {}

class _$SecureStorageModule extends _i256.SecureStorageModule {}
