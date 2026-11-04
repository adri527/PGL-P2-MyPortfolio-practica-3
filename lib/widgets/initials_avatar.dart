import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/app_colors.dart';

/// Círculo con las iniciales del usuario (sustituye a una foto).
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = 90,
  });

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accent,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
