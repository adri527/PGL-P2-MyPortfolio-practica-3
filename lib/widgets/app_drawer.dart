import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/constants/app_colors.dart';
import 'package:my_portfolio/constants/app_routes.dart';
import 'package:my_portfolio/constants/portfolio_data.dart';
import 'package:my_portfolio/widgets/initials_avatar.dart';

/// Elemento del menú: texto, icono y ruta a la que lleva.
class _DrawerItem {
  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;
}

/// Menú lateral común a todas las pantallas.
/// Para añadir una pantalla nueva basta con añadir un _DrawerItem a la lista.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const List<_DrawerItem> _items = [
    _DrawerItem(
      title: 'Bienvenida',
      icon: Icons.home,
      route: AppRoutes.welcome,
    ),
    _DrawerItem(
      title: 'Mi portfolio',
      icon: Icons.person,
      route: AppRoutes.portfolio,
    ),
    _DrawerItem(
      title: 'Mis hobbies',
      icon: Icons.list_alt,
      route: AppRoutes.hobbies,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Ruta actual, para resaltar la opción seleccionada.
    final String currentRoute = GoRouterState.of(context).uri.path;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InitialsAvatar(initials: PortfolioData.initials, size: 64),
                SizedBox(height: 12),
                Text(
                  PortfolioData.fullName,
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  PortfolioData.role,
                  style: TextStyle(color: AppColors.textLight),
                ),
              ],
            ),
          ),
          for (final item in _items)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              selected: currentRoute == item.route,
              selectedColor: AppColors.primary,
              onTap: () {
                Navigator.of(context).pop(); // cierra el Drawer
                context.go(item.route); // navega con go_router
              },
            ),
        ],
      ),
    );
  }
}
