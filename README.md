# PGL-P2-MyPortfolio

Portfolio personal desarrollado en Flutter para el módulo de Programación Multimedia y Dispositivos Móviles (2º DAM).

**Autor:** 
Adrián Jacob Ramos Reverón

## Descripción

App con una pantalla de bienvenida, una pantalla de portfolio con presentación y hobbies y, en la Tarea 3, una pantalla CRUD de hobbies. La navegación se hace desde un Drawer que resalta la opción actual.

## Funcionalidades

- Navegación con Drawer y `go_router`.
- **Pantalla CRUD de hobbies** (`/hobbies`) con lista dinámica:
  - Botón flotante que abre un modal (`AlertDialog`) con formulario: nombre, descripción breve y categoría (Deporte, Series y cine, Videojuegos, Música, Cocina, Naturaleza u Otros), con validación.
  - La categoría determina la imagen (icono) que se muestra junto al hobby.
  - Cada hobby tiene un botón para borrarlo.
  - Marcador con el número total de hobbies.
- Colores del diseño centralizados en `AppColors`.

## Rutas

| Ruta | Pantalla |
|---|---|
| `/` | Bienvenida |
| `/portfolio` | Mi portfolio |
| `/hobbies` | Mis hobbies (CRUD) |

## Estructura de `lib/`

```
lib/
├── constants/
├── models/
│   ├── hobby.dart
│   └── hobby_category.dart
├── router/
│   └── app_router.dart
├── screens/
│   ├── welcome_screen.dart
│   ├── portfolio_screen.dart
│   └── hobbies_screen.dart
├── widgets/
│   ├── add_hobby_dialog.dart
│   ├── app_drawer.dart
│   ├── hobby_card.dart
│   ├── hobbies_counter.dart
│   ├── hobby_chip.dart
│   └── initials_avatar.dart
└── main.dart


## Cómo ejecutarla

flutter pub get
flutter run -d chrome

