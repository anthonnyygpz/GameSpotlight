# Game-Spotlight (game_tv)

¡Bienvenido a **Game-Spotlight**! Este es un proyecto de Flutter diseñado con las mejores prácticas arquitectónicas para garantizar escalabilidad, mantenibilidad y un código limpio.

## 🏗️ Arquitectura del Proyecto

El proyecto sigue una arquitectura **Feature-First** (orientada a funcionalidades), lo que significa que el código se organiza alrededor de las características de la aplicación en lugar de por tipos de archivos técnicos. Esto facilita la colaboración y el escalado a medida que el proyecto crece.

Herramientas y librerías principales:
- **Gestión de Estado (State Management):** `flutter_riverpod`
- **Enrutamiento (Routing):** `go_router`
- **UI & Tipografía:** `google_fonts`, `dpad` (para navegación direccional, muy útil en interfaces de TV) y `pretty_qr_code`.

### Estructura de Directorios

La estructura principal del código se encuentra en el directorio `/lib`:

```text
lib/
 ├── core/              # Código transversal y compartido por toda la app
 │   ├── constants/     # Constantes globales (colores, temas, strings, assets)
 │   ├── routes/        # Configuración de enrutamiento con go_router
 │   └── widgets/       # Componentes visuales reutilizables (botones genéricos, loaders, etc.)
 │
 ├── features/          # Funcionalidades específicas y aisladas de la app
 │   ├── auth/          # Lógica, estado y pantallas de autenticación
 │   └── home/          # Lógica, estado y pantallas principales (Dashboard/Home)
 │
 ├── app.dart           # Configuración base del framework (MaterialApp/CupertinoApp, Themes)
 └── main.dart          # Punto de entrada de la aplicación (runApp y ProviderScope)
```

#### ¿Cómo localizar y modificar el código?
Si necesitas realizar un cambio o resolver un bug, hazte la siguiente pregunta: **¿Esto pertenece a una funcionalidad específica o es algo global?**
1. **Componentes Globales:** Si quieres modificar un botón que se usa en toda la app o agregar un nuevo color a la paleta, debes ir a `lib/core/`.
2. **Modificaciones Específicas:** Si hay un error en el inicio de sesión, debes buscar exclusivamente dentro de `lib/features/auth/`.
3. **Nuevas Pantallas:** Si creas una pantalla nueva, debes registrar su ruta en `lib/core/routes/`.

---

## 🚀 Guía de Instalación y Ejecución

Para configurar y levantar este proyecto en tu entorno local, sigue estos pasos:

### 1. Pre-requisitos
Asegúrate de cumplir con los siguientes requisitos en tu máquina:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) configurado (requiere versión Dart SDK `^3.12.1`).
- IDE recomendado: **VS Code** o **Android Studio** con las extensiones de Flutter y Dart.
- Un dispositivo físico conectado (recomendado TV o dispositivo con pad direccional) o un emulador de Android/iOS en ejecución.

### 2. Preparar el entorno
Si acabas de clonar el repositorio, navega a la raíz del proyecto y descarga todas las dependencias definidas en el archivo `pubspec.yaml`:
```bash
# Navegar al proyecto
cd game_tv

# Obtener dependencias de pub.dev
flutter pub get
```

### 3. Ejecutar la aplicación
Compila y despliega la aplicación en el dispositivo activo:
```bash
flutter run
```

---

## 🛠️ ¿Cómo añadir una nueva Funcionalidad (Feature)?

Para mantener la salud de la arquitectura, cuando necesites agregar una nueva área a la aplicación (por ejemplo, una pantalla de `settings` o `profile`):

1. **Crear el módulo:** Crea una nueva subcarpeta dentro de `lib/features/` llamada `settings`.
2. **Separación de responsabilidades:** Dentro de tu nueva feature, te recomendamos dividir el código internamente (Ej. Arquitectura limpia o por capas simples):
   - `presentation/`: Archivos de interfaz gráfica (`screens`, `widgets` exclusivos de esta feature).
   - `providers/` o `controllers/`: Lógica de estado usando Riverpod.
   - `models/`: Clases de datos.
3. **Enrutamiento:** Una vez terminada la vista principal de la feature, regístrala en el manejador de rutas en `lib/core/routes/`.
4. **Estado:** Utiliza `ConsumerWidget` o `ConsumerState` provistos por Riverpod para escuchar o modificar el estado de manera reactiva.

> 💡 *Tip de Arquitecto: Mantén las dependencias entre features al mínimo. Un módulo en `features/home` no debería depender directamente de implementaciones internas de `features/auth`. Comunícalos a través del estado global o el enrutamiento.*
