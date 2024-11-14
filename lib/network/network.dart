import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/model/productModel.dart';
import 'package:shop/model/userModel.dart';

class NetworkRequest {
  static const String url = 'https://dummyjson.com';
  static Future<List<Product>> fetchProBeauty({int page = 1}) async {
    final response = await http.get(Uri.parse("$url/product/category/beauty"));

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      final List<dynamic> productsJson = jsonData['products'];

      return productsJson.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Products: ${response.statusCode}');
    }
  }

  static Future<Product> fetchProductData(int id) async {
    final response = await http.get(Uri.parse('$url/products/$id'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$url/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data.containsKey('accessToken') && data.containsKey('refreshToken')) {
        return {
          'accessToken': data['accessToken'],
        };
      } else if (data.containsKey('message') &&
          data['message'] == 'Invalid credentials') {
        return {'message': 'Invalid credentials'};
      }
    } else {
      return {'message': 'Request failed with status: ${response.statusCode}'};
    }
    return {'message': 'Unexpected error occurred'};
  }

  static Future<User> fetchUserData(String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/auth/me'),
      headers: {
        'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<List<ProCart>> fetchCart(int id) async {
    final response = await http.get(Uri.parse('$url/carts/$id'));

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      final List<dynamic> productsJson = jsonData['products'];
      return productsJson.map((item) => ProCart.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Products: ${response.statusCode}');
    }
  }
}
