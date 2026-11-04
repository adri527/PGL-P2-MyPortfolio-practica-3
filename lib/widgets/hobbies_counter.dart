import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/app_colors.dart';

/// Marcador con el número total de hobbies de la lista.
class HobbiesCounter extends StatelessWidget {
  const HobbiesCounter({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.format_list_numbered, color: AppColors.primary),
      label: Text(
        'Total de hobbies: $total',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
      backgroundColor: AppColors.surface,
    );
  }
}
