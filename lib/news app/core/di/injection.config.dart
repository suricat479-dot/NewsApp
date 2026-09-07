// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/news%20app/core/di/injection.dart' as _i257;
import 'package:news_app/news%20app/data/data_source/remote/news_data_source_impl.dart'
    as _i675;
import 'package:news_app/news%20app/data/repositories/news_repository_impl.dart'
    as _i1056;
import 'package:news_app/news%20app/domain/repositories/news_repository.dart'
    as _i861;
import 'package:news_app/news%20app/domain/usecases/get_top_headlines.dart'
    as _i836;
import 'package:news_app/news%20app/ui/providers/news_provider.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Client>(() => registerModule.client);
    gh.lazySingleton<_i675.NewsRemoteDataSource>(
      () => _i675.NewsRemoteDataSourceImpl(client: gh<_i519.Client>()),
    );
    gh.lazySingleton<_i861.NewsRepository>(
      () => _i1056.NewsRepositoryImpl(
        remoteDataSource: gh<_i675.NewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i836.GetTopHeadlines>(
      () => _i836.GetTopHeadlines(gh<_i861.NewsRepository>()),
    );
    gh.factory<_i454.NewsProvider>(
      () => _i454.NewsProvider(
        getTopHeadlinesUseCase: gh<_i836.GetTopHeadlines>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i257.RegisterModule {}
