// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:game_tv/core/domain/categories/entity/category_entity.dart';
// import 'package:game_tv/core/domain/games/entities/game_entity.dart';
// import 'package:game_tv/core/domain/trailer_categories/entity/trailer_categories_entity.dart';
// import 'package:game_tv/core/domain/trailers/entities/trailer_entity.dart';
// import 'package:game_tv/core/providers/categories/categories_provider.dart';
// import 'package:game_tv/core/providers/games/games_provider.dart';
// import 'package:game_tv/core/providers/trailer_categories/trailer_categories.dart';
// import 'package:game_tv/core/providers/trailers/trailers_provider.dart';
// import 'package:game_tv/features/home/models/unified_game.dart';
//
// final homeAggregatorProvider = FutureProvider<List<UnifiedGame>>((ref) async {
//   final results = await Future.wait([
//     ref.read(gamesProvider.future),
//     ref.read(categoriesProvider.future),
//     ref.read(trailerCategoriesProvider.future),
//     ref.read(trailersProvider.future),
//   ]);
//
//   final games = results[0] as List<GameEntity>;
//   final categories = results[1] as List<CategoryEntity>;
//   final trailerCategories = results[2] as List<TrailerCategoryEntity>;
//   final trailers = results[3] as List<TrailerEntity>;
//
//   // return _buildUnifiedGames(games, categories, trailerCategories, trailers);
// });
//
// final upcomingGamesProvider = Provider<List<UnifiedGame>>((ref) {
//   return ref.watch(homeAggregatorProvider).whenData((games) {
//         return games
//             .where((game) => game.category?.categoryId == '1')
//             .take(10)
//             .toList();
//       }).value ??
//       [];
// });
//
// // List<UnifiedGame> _buildUnifiedGames(
// //   List<GameEntity> games,
// //   List<CategoryEntity> categories,
// //   List<TrailerCategoryEntity> trailerCategories,
// //   List<TrailerEntity> trailers,
// // ) {
//   // final categoryMap = _buildCategoryMap(categories);
//   // final trailersByGame = _buildTrailersByGame(trailers);
//   // final categoryByGame = _buildCategoryByGame(
//   //   trailerCategories,
//   //   trailers,
//   //   categoryMap,
//   // );
//   //
//   // return games
//   //     .map(
//   //       (game) => UnifiedGame(
//   //         id: game.idJuego,
//   //         title: game.titulo,
//   //         slug: game.slug,
//   //         sinopsis: game.sinopsis,
//   //         fechaLanzamiento: game.fechaLanzamiento,
//   //         desarrollador: game.desarrollador,
//   //         editor: game.editor,
//   //         imagenPortada: game.imagenPortada,
//   //         bannerUrl: game.bannerUrl,
//   //         estado: game.estado,
//   //         destacado: game.destacado,
//   //         createdAt: game.createdAt,
//   //         updatedAt: game.updatedAt,
//   //         trailers: trailersByGame[game.idJuego] ?? [],
//   //         category: categoryByGame[game.idJuego],
//   //       ),
//   //     )
//   //     .toList();
// // }
//
// Map<String, CategoryEntity> _buildCategoryMap(
//   List<CategoryEntity> categories,
// ) => {for (final category in categories) category.categoryId: category};
//
// Map<String, CategoryEntity> _buildCategoryByGame(
//   List<TrailerCategoryEntity> trailerCategories,
//   List<TrailerEntity> trailers,
//   Map<String, CategoryEntity> categoryMap,
// ) {
//   final trailerToGame = {for (final t in trailers) t.idTrailer: t.idJuego};
//
//   final result = <String, CategoryEntity>{};
//
//   for (final pivot in trailerCategories) {
//     final idJuego = trailerToGame[pivot.trailerId];
//     final category = categoryMap[pivot.categoryId];
//
//     if (idJuego != null && category != null) {
//       result[idJuego] = category;
//     }
//   }
//
//   return result;
// }
//
// Map<String, List<TrailerEntity>> _buildTrailersByGame(
//   List<TrailerEntity> trailers,
// ) {
//   final result = <String, List<TrailerEntity>>{};
//   for (final trailer in trailers) {
//     result.putIfAbsent(trailer.idJuego, () => []).add(trailer);
//   }
//   return result;
// }
