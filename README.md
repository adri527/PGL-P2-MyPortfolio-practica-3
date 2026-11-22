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
- Paquete [`http`](https://pub.dev/packages/http)
- Paquete [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage)
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
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── welcome_screen.dart
│   ├── portfolio_screen.dart
│   └── hobbies_screen.dart
├── services/
│   ├── auth_api.dart
│   ├── session_controller.dart
│   └── token_storage.dart
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
| `/login` | Inicio de sesión |
| `/register` | Registro |
| `/` | Bienvenida (requiere sesión válida) |
| `/portfolio` | Mi portfolio |
| `/hobbies` | Mis hobbies (CRUD) |

## Sesión de usuario (Tarea 5)

- Al arrancar se muestra el login y se comprueba el JWT guardado; las rutas internas quedan protegidas hasta validar el token.
- El registro envía nombre completo, email y contraseña, valida los campos y muestra la respuesta de la API en una alerta. Tras registrarse correctamente vuelve al login.
- El login muestra la respuesta en una alerta y guarda el JWT con `flutter_secure_storage`.
- La pantalla de bienvenida tiene un botón que consulta el endpoint protegido y presenta su mensaje real.
- El Drawer permite cerrar sesión, borrar el JWT y volver al login.
- Las solicitudes HTTP están encapsuladas en `lib/services/auth_api.dart`; el acceso al almacenamiento seguro está en `lib/services/token_storage.dart`.
- Contrato confirmado en el [código y documentación de la API del profesor](https://github.com/adhernea/my-users-api/blob/main/docs/endpoints_api.md). Base URL: `https://my-users-api.onrender.com`.

## Ejecución

```bash
git clone <URL-del-repositorio>
cd PGL-P2-MyPortfolio
flutter pub get
flutter run -d chrome
```

## Capturas de pantalla

| Bienvenida | Drawer | Portfolio |
|---|---|---|
| ![Bienvenida](docs/screenshots/bienvenida.png) | ![Drawer](docs/screenshots/drawer.png) | ![Portfolio](docs/screenshots/portfolio.png) |

| Lista vacía | Modal de alta | Lista con hobbies |
|---|---|---|
| ![Lista vacía](docs/screenshots/hobbies_vacia.png) | ![Modal](docs/screenshots/hobbies_modal.png) | ![Lista](docs/screenshots/hobbies_lista.png) |

### Capturas reales de Tarea 5 pendientes

Estas capturas deben tomarse al ejecutar los flujos contra la API. No se incluyen imágenes ficticias ni se afirma que los flujos se hayan probado en vivo.

- Registro exitoso.
- Login fallido.
- Login exitoso.
- Mensaje recibido del endpoint de bienvenida.

Cuando estén disponibles, guárdalas en `docs/screenshots/` y enlázalas aquí.

## Comprobaciones realizadas

- `flutter pub get`: correcto.
- `dart analyze`: sin problemas.
- `flutter test`: 7 pruebas aprobadas (contrato HTTP, validación/restauración de JWT y cierre de sesión).
- `flutter build web --release`: compilación correcta para Chrome.
- `flutter build apk --debug`: compilación correcta para Android.

`flutter analyze` terminó con un fallo interno del servidor de análisis de esta instalación de Flutter (mensaje LSP incompleto); `dart analyze` ejecutado directamente sí terminó correctamente.

Las pruebas automatizadas usan respuestas simuladas; no se creó ningún usuario real en la API ni se completaron los flujos de extremo a extremo. Las cuatro capturas nuevas siguen pendientes de una ejecución real.

## Entrega

Rama de trabajo: `P2-Tarea5-SesionUsuario` (creada desde `develop`)

## Autor

Adrián Jacob Ramos Reverón

## Asignatura

Programación Multimedia y Dispositivos Móviles · 2º DAM
