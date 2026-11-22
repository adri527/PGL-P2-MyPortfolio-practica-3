import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/constants/app_colors.dart';
import 'package:my_portfolio/constants/app_routes.dart';
import 'package:my_portfolio/constants/portfolio_data.dart';
import 'package:my_portfolio/services/auth_api.dart';
import 'package:my_portfolio/services/session_controller.dart';
import 'package:my_portfolio/widgets/app_drawer.dart';
import 'package:my_portfolio/widgets/initials_avatar.dart';

/// Pantalla de bienvenida: avatar, saludo y botón hacia el portfolio.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _showWelcomeMessage(BuildContext context) async {
    String message;
    try {
      message = await sessionController.requestWelcome();
    } on ApiException catch (error) {
      message = error.message;
    } catch (_) {
      message = 'No se pudo obtener el mensaje de bienvenida.';
    }
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Respuesta de la API'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenida')),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const InitialsAvatar(initials: PortfolioData.initials, size: 140),
              const SizedBox(height: 24),
              const Text(
                '¡Bienvenido a mi portfolio!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '${PortfolioData.fullName}\n${PortfolioData.role}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.textDark),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => context.go(AppRoutes.portfolio),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Ver mi portfolio'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _showWelcomeMessage(context),
                icon: const Icon(Icons.waving_hand_outlined),
                label: const Text('Consultar mensaje de bienvenida'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
