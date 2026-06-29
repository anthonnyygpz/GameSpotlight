---
name: nuevo_repositorio_crud
description: >
  Úsala cuando el usuario pida crear un repositorio NUEVO en un proyecto Flutter con Clean Architecture
  que ya incluya los métodos CRUD (getAll, getById, create, update, delete) como firmas vacías,
  sin contenido en el cuerpo de las funciones (solo el esqueleto).
  Triggers: "crea un crud de X", "genera el crud de X", "crea un repositorio con CRUD para X",
  "nuevo repositorio con las funciones vacías", "crea el datasource y repository de X sin lógica adentro",
  "solo las firmas, sin contenido", "estructura CRUD vacía para X".
  También se activa cuando el usuario pide generar datasource + repository con métodos CRUD pero
  deja explícito que las funciones deben quedar vacías / sin implementación.
  NO usar para modificar repositorios ya existentes ni para generar implementaciones reales (con lógica) de los métodos.
---

# Nuevo Repositorio con CRUD (vacío)

## Cuándo usarla

- El usuario pide crear un repositorio que NO existe aún en `lib/core/data/` y `lib/core/domain/`
- El usuario quiere que el repositorio incluya de entrada los métodos CRUD estándar: `getAll`, `getById`, `create`, `update`, `delete`
- El usuario pide explícitamente que las funciones queden **vacías / sin contenido** (solo el esqueleto, sin lógica, sin `TODO`, sin `throw UnimplementedError()`)
- El usuario puede proporcionar campos/propiedades opcionales con sus tipos (ej. `id: String`, `title: String`, `rating: double`)
- NO usar para modificar repositorios existentes
- NO usar si el usuario quiere los métodos **implementados** (con lógica real) — en ese caso, no aplica esta skill

---

## Diferencia clave con `nuevo_repositorio`

Esta skill genera la misma estructura de carpetas que `nuevo_repositorio`, pero además agrega los 5 métodos CRUD como firmas vacías en:

- `domain/repository/<nombre>_repository.dart` (clase abstracta) → tipado con la **Entity**
- `data/datasource/<nombre>_remote_datasource.dart` → tipado con **`dynamic`**
- `data/repository/<nombre>_repository_impl.dart` → implementa la interfaz, cuerpo de cada método **vacío**

El `model` y el `entity` se generan exactamente igual que en `nuevo_repositorio` (con o sin campos, según inferencia de tipos).

---

## Convenciones de nombres

Dado el nombre `<nombre>` (ej. `user_profile`):

| Variable            | Regla              | Ejemplo               |
|---------------------|--------------------|-----------------------|
| `<nombre>`          | snake_case         | `user_profile`        |
| `<NombrePascal>`    | PascalCase         | `UserProfile`         |
| `<nombreCamel>`     | camelCase          | `userProfile`         |

---

## Inferencia de campos

Misma tabla que `nuevo_repositorio`:

| Patrón de nombre                          | Tipo inferido     |
|--------------------------------------------|-------------------|
| `id`                                       | `String`          |
| `*_id`, `*Id`                               | `String`          |
| `title`, `name`, `description`, `*_url`    | `String`          |
| `*_at`, `*At`, `*_date`, `*Date`           | `DateTime`        |
| `rating`, `score`, `price`, `*_count`      | `double`          |
| `count`, `quantity`, `*_num`, `index`      | `int`             |
| `is_*`, `has_*`, `*_enabled`, `*_active`  | `bool`            |
| listas explícitas (`tags`, `images`)       | `List<String>`    |
| cualquier otro                             | `String`          |

Todos los campos se generan como **requeridos y no nulos** por defecto, salvo que el usuario indique `?` (nullable).

---

## Pasos

### 1. Verificar que no exista

Revisar que NO exista ninguna carpeta con ese nombre en:
- `lib/core/data/<nombre>/`
- `lib/core/domain/<nombre>/`

Si existe → **detente y notifica. No continúes.**
Si no existe → continúa.

---

### 2. Determinar los campos

Igual que en `nuevo_repositorio`:
- Si el usuario proporcionó campos, parsearlos como `nombre: Tipo` o `nombre` (inferir tipo).
- Si no proporcionó campos, generar entity y model **vacíos** (sin propiedades).

---

### 3. Crear estructura en `data/`

```
lib/core/data/<nombre>/
  datasource/
  model/
  repository/
```

#### 3a. `datasource/<nombre>_remote_datasource.dart`

La clase abstracta/concreta del datasource declara los 5 métodos CRUD con cuerpo vacío. Los tipos de retorno y parámetros usan **`dynamic`** (no la Entity ni el Model), ya que el datasource solo mueve datos crudos.

```dart
import 'package:dio/dio.dart';

class <NombrePascal>RemoteDataSource {
  final Dio client;

  <NombrePascal>RemoteDataSource(this.client);

  // Future<List<dynamic>> getAll() {
  //
  // }

  // Future<dynamic> getById(String id) {
  //
  // }

  // Future<dynamic> create(Map<String, dynamic> data) {
  //
  // }

  // Future<dynamic> update(String id, Map<String, dynamic> data) {
  //
  // }

  // Future<void> delete(String id) {
  //
  // }
}
```

> **Nota:** Cada método se deja **comentado por completo** (firma + cuerpo), no solo con cuerpo vacío. Esto es porque en Dart un método con tipo de retorno no-`void` y cuerpo `{}` no compila (falta el `return`). Al comentar la función entera, el archivo siempre compila tal cual se genera, y el usuario solo tiene que descomentar y rellenar cada método cuando lo necesite. No se agrega `TODO` ni `UnimplementedError`, solo el esqueleto comentado.

---

#### 3b. `model/<nombre>_model.dart`

Idéntico a `nuevo_repositorio` (sin cambios): con o sin campos según el paso 2.

**Sin campos (vacío):**
```dart
import 'package:game_tv/core/domain/<nombre>/entity/<nombre>_entity.dart';

class <NombrePascal>Model extends <NombrePascal>Entity {
  const <NombrePascal>Model() : super();

  factory <NombrePascal>Model.fromJson(Map<String, dynamic> json) {
    return <NombrePascal>Model();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
```

**Con campos** (ejemplo con `id: String`, `title: String`, `rating: double`):
```dart
import 'package:game_tv/core/domain/<nombre>/entity/<nombre>_entity.dart';

class <NombrePascal>Model extends <NombrePascal>Entity {
  const <NombrePascal>Model({
    required super.id,
    required super.title,
    required super.rating,
  });

  factory <NombrePascal>Model.fromJson(Map<String, dynamic> json) {
    return <NombrePascal>Model(
      id: json['id'] as String,
      title: json['title'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
    };
  }
}
```

> Mismas reglas de `fromJson` por tipo y de conversión camelCase → snake_case para las keys del JSON que en `nuevo_repositorio`.

---

#### 3c. `repository/<nombre>_repository_impl.dart`

Implementa la interfaz `<NombrePascal>Repository` (domain). Cada método CRUD queda **vacío**, tipado con la **Entity** (porque implementa el contrato del domain, no del datasource).

```dart
import 'package:game_tv/core/data/<nombre>/datasource/<nombre>_remote_datasource.dart';
import 'package:game_tv/core/domain/<nombre>/entity/<nombre>_entity.dart';
import 'package:game_tv/core/domain/<nombre>/repository/<nombre>_repository.dart';

class <NombrePascal>RepositoryImpl implements <NombrePascal>Repository {
  final <NombrePascal>RemoteDataSource remoteDataSource;

  <NombrePascal>RepositoryImpl(this.remoteDataSource);

  // @override
  // Future<List<<NombrePascal>Entity>> getAll() {
  //
  // }

  // @override
  // Future<<NombrePascal>Entity> getById(String id) {
  //
  // }

  // @override
  // Future<<NombrePascal>Entity> create(<NombrePascal>Entity entity) {
  //
  // }

  // @override
  // Future<<NombrePascal>Entity> update(<NombrePascal>Entity entity) {
  //
  // }

  // @override
  // Future<void> delete(String id) {
  //
  // }
}
```

> **Nota:** Igual que en el datasource, cada método (con su `@override`) se deja **comentado por completo** para evitar errores de compilación por tipo de retorno no-`void` sin `return`. Como la clase `implements <NombrePascal>Repository` pero no define los métodos del contrato (porque están comentados), Dart marcará la clase como incompleta hasta que se descomenten — esto es esperado y es justamente la señal de "pendiente de implementar".

---

### 4. Crear estructura en `domain/`

```
lib/core/domain/<nombre>/
  entity/
  repository/
```

#### 4a. `entity/<nombre>_entity.dart`

Idéntico a `nuevo_repositorio` (sin cambios).

**Sin campos (vacío):**
```dart
class <NombrePascal>Entity {
  const <NombrePascal>Entity();
}
```

**Con campos** (ejemplo con `id: String`, `title: String`, `rating: double`):
```dart
class <NombrePascal>Entity {
  final String id;
  final String title;
  final double rating;

  const <NombrePascal>Entity({
    required this.id,
    required this.title,
    required this.rating,
  });
}
```

> Para campos **nullable** usar `final String? campo;` y omitir `required` en el constructor.

---

#### 4b. `repository/<nombre>_repository.dart`

Clase abstracta (contrato del domain). Declara los 5 métodos CRUD **sin cuerpo** (firma de interfaz, terminan en `;`), tipados con la **Entity**.

```dart
import 'package:game_tv/core/domain/<nombre>/entity/<nombre>_entity.dart';

abstract class <NombrePascal>Repository {
  Future<List<<NombrePascal>Entity>> getAll();

  Future<<NombrePascal>Entity> getById(String id);

  Future<<NombrePascal>Entity> create(<NombrePascal>Entity entity);

  Future<<NombrePascal>Entity> update(<NombrePascal>Entity entity);

  Future<void> delete(String id);
}
```

---

## Resumen de archivos creados

Para un nombre `<nombre>`:

```
lib/core/
├── data/
│   └── <nombre>/
│       ├── datasource/
│       │   └── <nombre>_remote_datasource.dart   (5 métodos CRUD vacíos, tipo dynamic)
│       ├── model/
│       │   └── <nombre>_model.dart                (igual que nuevo_repositorio)
│       └── repository/
│           └── <nombre>_repository_impl.dart      (5 métodos CRUD vacíos, tipo Entity)
└── domain/
    └── <nombre>/
        ├── entity/
        │   └── <nombre>_entity.dart               (igual que nuevo_repositorio)
        └── repository/
            └── <nombre>_repository.dart           (5 firmas CRUD abstractas, tipo Entity)
```

**Total: 5 archivos generados.**

---

## Ejemplo completo

Input: `"crea el crud de game con campos: id, title, rating: double"`

`game_entity.dart`:
```dart
class GameEntity {
  final String id;
  final String title;
  final double rating;

  const GameEntity({
    required this.id,
    required this.title,
    required this.rating,
  });
}
```

`game_repository.dart` (domain):
```dart
import 'package:game_tv/core/domain/game/entity/game_entity.dart';

abstract class GameRepository {
  Future<List<GameEntity>> getAll();

  Future<GameEntity> getById(String id);

  Future<GameEntity> create(GameEntity entity);

  Future<GameEntity> update(GameEntity entity);

  Future<void> delete(String id);
}
```

`game_remote_datasource.dart` (data):
```dart
import 'package:dio/dio.dart';

class GameRemoteDataSource {
  final Dio client;

  GameRemoteDataSource(this.client);

  // Future<List<dynamic>> getAll() {
  //
  // }

  // Future<dynamic> getById(String id) {
  //
  // }

  // Future<dynamic> create(Map<String, dynamic> data) {
  //
  // }

  // Future<dynamic> update(String id, Map<String, dynamic> data) {
  //
  // }

  // Future<void> delete(String id) {
  //
  // }
}
```

`game_repository_impl.dart` (data):
```dart
import 'package:game_tv/core/data/game/datasource/game_remote_datasource.dart';
import 'package:game_tv/core/domain/game/entity/game_entity.dart';
import 'package:game_tv/core/domain/game/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameRemoteDataSource remoteDataSource;

  GameRepositoryImpl(this.remoteDataSource);

  // @override
  // Future<List<GameEntity>> getAll() {
  //
  // }

  // @override
  // Future<GameEntity> getById(String id) {
  //
  // }

  // @override
  // Future<GameEntity> create(GameEntity entity) {
  //
  // }

  // @override
  // Future<GameEntity> update(GameEntity entity) {
  //
  // }

  // @override
  // Future<void> delete(String id) {
  //
  // }
}
```

`game_model.dart` (data): igual que en `nuevo_repositorio`, con los mismos campos.
