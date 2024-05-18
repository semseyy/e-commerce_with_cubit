import 'package:dio/dio.dart';
import 'package:ecommerce_with_cubit/feature/home/model/home_model.dart';

class FakeStoreService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://fakestoreapi.com';

  /// Fetches all products from the API.
  Future<List<Product>> getProducts() async {
    try {
      Response response = await _dio.get('$_baseUrl/products');
      List<dynamic> data = response.data;
      List<Product> products = data.map((json) => Product.fromJson(json)).toList();
      return products;
    } catch (e) {
      print("Exception occurred while fetching products: $e");
      throw e; // Rethrow the exception or handle it appropriately
    }
  }

  /// Fetches a product by its ID from the API.
  Future<Product> getProductById(int productId) async {
    try {
      Response response = await _dio.get('$_baseUrl/products/$productId');
      if (response.statusCode == 200) {
        print("Ürün Bilgileri: ${response.data}");
        return Product.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch product. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching product: $e");
      throw e; //
    }
  }

  /// Fetches products by category from the API.
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      Response response = await _dio.get('$_baseUrl/products/category/$category');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Product> products = data.map((json) => Product.fromJson(json)).toList();
        print('denemeee: $products');
        return products;
      } else {
        throw Exception("Failed to load products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching products by category: $e");
      throw e; // Rethrow the exception or handle it appropriately
    }
  }

  Future<dynamic> getProductInfo(int productId) async {
    try {
      Response response = await _dio.get('$_baseUrl/products/$productId');
      return response.data;
    } catch (error) {
      print('Error fetching product: $error');
      throw error;
    }
  }
}
