import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/app_colors.dart';

/// Cuadro redondeado que muestra un hobby.
class HobbyChip extends StatelessWidget {
  const HobbyChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 15, color: AppColors.textDark),
      ),
    );
  }
}
