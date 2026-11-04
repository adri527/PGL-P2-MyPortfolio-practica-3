import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/app_colors.dart';
import 'package:my_portfolio/models/hobby.dart';

/// Tarjeta de un hobby: imagen (icono) de su categoría a la izquierda,
/// nombre y descripción en el centro y botón de borrar a la derecha.
class HobbyCard extends StatelessWidget {
  const HobbyCard({super.key, required this.hobby, required this.onDelete});

  final Hobby hobby;
  final VoidCallback onDelete; // el padre decide qué pasa al borrar

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // La categoría decide qué imagen se muestra al lado del hobby.
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          child: Icon(hobby.category.icon, size: 28),
        ),
        title: Text(
          hobby.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hobby.category.label,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(hobby.description),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Borrar',
          onPressed: onDelete,
        ),
      ),
    );
  }
}
