import 'package:dio/dio.dart';
import 'package:ecommerce_with_cubit/feature/home/model/home_model.dart';

class FakeStoreService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://fakestoreapi.com';

  // Tüm ürünleri getiren metod
  Future<List<Product>?> getProducts() async {
    try {
      Response response = await _dio.get('$_baseUrl/products');
      List<dynamic> data = response.data;
      List<Product> products = data.map((json) => Product.fromJson(json)).toList();
      return products;
    } catch (e) {
      print("Exception occured: $e");
      return null;
    }
  }

  // ID'si verilen ürünü getiren metod
  Future<Map<String, dynamic>?> getProductById(int productId) async {
    try {
      Response response = await _dio.get('$_baseUrl/products/$productId');
      return response.data;
    } catch (e) {
      print("Exception occured: $e");
      return null;
    }
  }

  // Kategoriye göre ürünleri getiren metod
  Future<List<dynamic>?> getProductsByCategory(String category) async {
    try {
      Response response = await _dio.get('$_baseUrl/products/category/$category');
      return response.data;
    } catch (e) {
      print("Exception occured: $e");
      return null;
    }
  }
}
