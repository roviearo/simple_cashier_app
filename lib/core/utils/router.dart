import 'package:go_router/go_router.dart';
import 'package:simple_cashier_app/src/authentication/presentation/view/login_register_screen.dart';
import 'package:simple_cashier_app/src/authentication/presentation/view/main_screen.dart';
import 'package:simple_cashier_app/src/authentication/presentation/view/splash_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: 'splash',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/main',
    name: 'main',
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
    path: '/login_register',
    name: 'login_register',
    builder: (context, state) => const LoginRegisterScreen(),
  ),
]);
