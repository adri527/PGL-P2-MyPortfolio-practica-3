import 'package:go_router/go_router.dart';
import 'package:my_portfolio/constants/app_routes.dart';
import 'package:my_portfolio/screens/hobbies_screen.dart';
import 'package:my_portfolio/screens/portfolio_screen.dart';
import 'package:my_portfolio/screens/welcome_screen.dart';

/// Configuración de navegación con go_router.
/// Cada GoRoute asocia una ruta (path) con la pantalla que se construye.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
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
