import 'package:go_router/go_router.dart';
import 'package:my_portfolio/constants/app_routes.dart';
import 'package:my_portfolio/screens/hobbies_screen.dart';
import 'package:my_portfolio/screens/login_screen.dart';
import 'package:my_portfolio/screens/portfolio_screen.dart';
import 'package:my_portfolio/screens/register_screen.dart';
import 'package:my_portfolio/screens/welcome_screen.dart';
import 'package:my_portfolio/services/session_controller.dart';

/// Configuración de navegación con go_router.
/// Cada GoRoute asocia una ruta (path) con la pantalla que se construye.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  refreshListenable: sessionController,
  redirect: (context, state) {
    final path = state.uri.path;
    final isAuthPage = path == AppRoutes.login || path == AppRoutes.register;
    if (!sessionController.initialized) {
      return path == AppRoutes.login ? null : AppRoutes.login;
    }
    if (sessionController.isAuthenticated) {
      return isAuthPage ? AppRoutes.welcome : null;
    }
    return isAuthPage ? null : AppRoutes.login;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.portfolio,
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      path: AppRoutes.hobbies,
      builder: (context, state) => const HobbiesScreen(),
    ),
  ],
);
