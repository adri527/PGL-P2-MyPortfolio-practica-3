import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/app_colors.dart';
import 'package:my_portfolio/constants/portfolio_data.dart';
import 'package:my_portfolio/widgets/app_drawer.dart';
import 'package:my_portfolio/widgets/hobby_chip.dart';
import 'package:my_portfolio/widgets/initials_avatar.dart';

/// Pantalla del portfolio: presentación + hobbies.
/// Usa ListView para que haga scroll y no haya desbordamiento (overflow).
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi portfolio')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tarjeta de presentación
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              spacing: 16,
              children: [
                InitialsAvatar(initials: PortfolioData.initials),
                Expanded(
                  child: Text(
                    PortfolioData.presentation,
                    style: TextStyle(fontSize: 16, color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Mis hobbies',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          // Wrap coloca los hobbies en filas y salta de línea si no caben.
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final hobby in PortfolioData.hobbies) HobbyChip(label: hobby),
            ],
          ),
        ],
      ),
    );
  }
}
