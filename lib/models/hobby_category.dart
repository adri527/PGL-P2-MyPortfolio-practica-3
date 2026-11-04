import 'package:flutter/material.dart';

/// Categorías posibles de un hobby. Cada una lleva su nombre y su icono.
/// Es un enum "mejorado": cada valor guarda datos, así no hacen falta
/// switch ni cadenas sueltas repartidas por la app.
enum HobbyCategory {
  sports('Deporte', Icons.sports_soccer),
  cinema('Series y cine', Icons.movie),
  games('Videojuegos', Icons.sports_esports),
  music('Música', Icons.music_note),
  cooking('Cocina', Icons.restaurant),
  nature('Naturaleza', Icons.terrain),
  other('Otros', Icons.category);

  const HobbyCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
