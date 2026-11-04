import 'package:flutter/material.dart';

/// Paleta de colores del nuevo diseño. Centralizada para no repetir
/// valores "mágicos" por toda la app.
abstract class AppColors {
  static const Color primary = Color(0xFF3949AB); // índigo
  static const Color accent = Color(0xFFFFB300); // ámbar
  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF1F2937);
  static const Color textLight = Colors.white;
}
