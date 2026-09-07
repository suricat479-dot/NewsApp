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
import 'package:news_app/news_app/core/di/injection.dart' as _i257;
import 'package:news_app/news_app/core/router/app_router.dart' as _i694;
import 'package:news_app/news_app/core/services/secure_storage_service.dart'
    as _i221;
import 'package:news_app/news_app/core/services/storage_service.dart'
    as _i372;
import 'package:news_app/news_app/data/data_source/abstract/news_data_source.dart'
    as _i69;
import 'package:news_app/news_app/data/data_source/remote/news_data_source_impl.dart'
    as _i675;
import 'package:news_app/news_app/data/repositories/news_repository_impl.dart'
    as _i1056;
import 'package:news_app/news_app/domain/repositories/news_repository.dart'
    as _i861;
import 'package:news_app/news_app/domain/usecases/get_top_headlines.dart'
    as _i836;
import 'package:news_app/news_app/domain/usecases/search_news.dart' as _i119;
import 'package:news_app/news_app/ui/providers/news_provider.dart' as _i454;
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
    gh.lazySingleton<_i694.AppRouter>(() => _i694.AppRouter());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => secureStorageModule.secureStorage);
    gh.lazySingleton<_i69.NewsDataSource>(
        () => _i675.NewsDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i372.StorageService>(
        () => _i372.StorageService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i861.NewsRepository>(() =>
        _i1056.NewsRepositoryImpl(newsDataSource: gh<_i69.NewsDataSource>()));
    gh.lazySingleton<_i221.SecureStorageService>(
        () => _i221.SecureStorageService(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i836.GetTopHeadlines>(
        () => _i836.GetTopHeadlines(gh<_i861.NewsRepository>()));
    gh.factory<_i119.SearchNews>(
        () => _i119.SearchNews(gh<_i861.NewsRepository>()));
    gh.factory<_i454.NewsProvider>(() => _i454.NewsProvider(
          getTopHeadlinesUseCase: gh<_i836.GetTopHeadlines>(),
          searchNewsUseCase: gh<_i119.SearchNews>(),
        ));
    return this;
  }
}

class _$StorageModule extends _i372.StorageModule {}

class _$RegisterModule extends _i257.RegisterModule {}

class _$SecureStorageModule extends _i221.SecureStorageModule {}
