import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/article.dart';
import '../../ui/screens/splash_page.dart';
import '../../ui/screens/onboarding_screen.dart';
import '../../ui/screens/auth_screen.dart';
import '../../ui/screens/news_screen.dart';
import '../../ui/screens/news_detail_screen.dart';
import '../../ui/screens/profile_page.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: NewsRoute.page),
        AutoRoute(page: NewsDetailRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ];
}