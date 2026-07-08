import 'package:dio/dio.dart';
import 'package:gamespotlight/core/constants/categories_test.dart';

class CategoriesRemoteDataSource {
  final Dio client;

  CategoriesRemoteDataSource(this.client);

  Future<List<dynamic>> getAll() async {
    return mockCategories
        .map((e) => {'categoryId': e.categoryId, 'name': e.name})
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
