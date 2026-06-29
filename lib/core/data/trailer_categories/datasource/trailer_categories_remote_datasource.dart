import 'package:dio/dio.dart';
import 'package:game_tv/core/constants/trailer_categories_test.dart';

class TrailerCategoriesRemoteDataSource {
  final Dio client;

  TrailerCategoriesRemoteDataSource(this.client);

  Future<List<dynamic>> getAll() async {
    return mockTrailerCategories
        .map((e) => {'trailer_id': e.trailerId, 'category_id': e.categoryId})
        .toList();
  }

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
