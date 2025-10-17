import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/presentation/features/auth/screens/sign_in_screen.dart';
import 'package:social_media_clone/presentation/features/home/moderator/screens/moderators_home_screen.dart';
import 'package:social_media_clone/presentation/features/home/superadmin/screen/super_admin_homescreen.dart';
import 'package:social_media_clone/presentation/features/home/user/screen/users_home_screen.dart';
import 'package:social_media_clone/presentation/features/profile/screens/profile_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),

      routes: {
        '/login': (ctx) => const SignInScreen(),
        '/user_home': (ctx) => const UserHomeScreen(),
        '/moderator_home': (ctx) => const ModeratorHomeScreen(),
        '/super_admin_home': (ctx) => const SuperAdminHomeScreen(),
        '/profile': (ctx) => const ProfileScreen(),
      },
      home: SignInScreen(),    
    );
  }
}
