# PGL-P2-MyPortfolio

Aplicación Flutter de portfolio personal desarrollada para la asignatura de **Programación Multimedia y Dispositivos Móviles** (2º DAM). Implementa la navegación entre pantallas con un menú lateral (`Drawer`) y la librería `go_router`.

## Descripción

Esta es la segunda práctica del portfolio. La app cuenta con una pantalla de bienvenida, una pantalla de portfolio con presentación y hobbies y, en la Tarea 3, una pantalla CRUD de hobbies. El usuario se mueve entre ellas desde el Drawer, que resalta la opción en la que se encuentra.

## Funcionalidades

- Navegación declarativa con `go_router` (rutas en `lib/router/app_router.dart`).
- `Drawer` reutilizable, común a todas las pantallas.
- **Pantalla de bienvenida** (`/`) con saludo y botón de acceso al portfolio.
- **Pantalla de portfolio** (`/portfolio`) con presentación y hobbies, con scroll para evitar desbordamientos.
- **Pantalla CRUD de hobbies** (`/hobbies`) con lista dinámica:
  - Botón flotante que abre un modal (`AlertDialog`) con formulario: nombre, descripción breve y selector de categoría (Deporte, Series y cine, Videojuegos, Música, Cocina, Naturaleza u Otros), con validación.
  - La categoría determina la imagen (icono) que se muestra junto al hobby.
  - Cada hobby tiene un botón para borrarlo.
  - Marcador con el número total de hobbies.
- Colores del diseño centralizados en `lib/constants/app_colors.dart`.
- Widgets pequeños y reutilizables (`AppDrawer`, `InitialsAvatar`, `HobbyChip`, `HobbyCard`, `HobbiesCounter`, `AddHobbyDialog`).

## Tecnologías utilizadas

- Flutter y Dart
- Paquete [`go_router`](https://pub.dev/packages/go_router)
- Material Design 3
- Visual Studio Code y Google Chrome

## Estructura del proyecto

```
lib/
├── main.dart
├── constants/
│   ├── app_colors.dart
│   ├── app_routes.dart
│   └── portfolio_data.dart
├── models/
│   ├── hobby_category.dart
│   └── hobby.dart
├── router/
│   └── app_router.dart
├── screens/
│   ├── welcome_screen.dart
│   ├── portfolio_screen.dart
│   └── hobbies_screen.dart
└── widgets/
    ├── add_hobby_dialog.dart
    ├── app_drawer.dart
    ├── hobby_chip.dart
    ├── initials_avatar.dart
    ├── hobby_card.dart
    └── hobbies_counter.dart
```

## Rutas

| Ruta | Pantalla |
|---|---|
| `/` | Bienvenida |
| `/portfolio` | Mi portfolio |
| `/hobbies` | Mis hobbies (CRUD) |

## Ejecución

```bash
git clone <URL-del-repositorio>
cd PGL-P2-MyPortfolio
flutter pub get
flutter run -d chrome
```

## Entrega

Rama: `P2-Tarea3-Formulario`

## Autor

Adrián Jacob Ramos Reverón


