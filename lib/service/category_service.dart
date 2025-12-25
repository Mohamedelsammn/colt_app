import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/category_model.dart';

class CategoriesService {
  static const String baseUrl =
      'https://dummyjson.com/products/categories';

  Future<List<Categories>> fetchCategories() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map((e) => Categories.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load categories'); 
    }
  }
}
