import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MemoryCacheManager extends CacheManager {
  static const _key = 'memoryCache';

  static final MemoryCacheManager _instance = MemoryCacheManager._();
  factory MemoryCacheManager() => _instance;

  MemoryCacheManager._()
    : super(
        Config(
          _key,
          // Sin repositorio en disco → solo memoria
          repo: NonStoringObjectProvider(),
        ),
      );
}
