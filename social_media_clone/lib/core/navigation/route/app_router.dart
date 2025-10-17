import 'package:auto_route/auto_route.dart';

import 'package:social_media_clone/presentation/features/auth/screens/sign_in_screen.dart';
import 'package:social_media_clone/presentation/features/auth/screens/sign_up_screen.dart';
import 'package:social_media_clone/presentation/features/home/moderator/screens/moderators_home_screen.dart';
import 'package:social_media_clone/presentation/features/home/superadmin/screen/super_admin_homescreen.dart';
import 'package:social_media_clone/presentation/features/home/user/screen/users_home_screen.dart';
import 'package:social_media_clone/presentation/features/profile/screens/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignInRoute.page, initial: true),
    AutoRoute(page: SignupRoute.page),
    AutoRoute(page: UserHomeRoute.page),
    AutoRoute(page: ModeratorHomeRoute.page),
    AutoRoute(page: SuperAdminHomeRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}
