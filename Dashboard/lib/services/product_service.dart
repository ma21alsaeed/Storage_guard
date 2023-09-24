import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/network.dart';
import '../models/product.dart';

class ProductService {


  static Future<Product> getProduct(int id) async {
    final response = await http.get(Uri.parse('$getProductEndPoint$id'),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer 1|LxkWNBprHUSUhOkANcKTj0H1vvQt1uicjZJc6Nzo'
    });
    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body)["product"];
      return Product.fromJson(jsonData);
    } else {
      throw Exception('Failed to load product');
    }
  }
  /*
  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


*/
static Future<Product> createProduct(Product product) async {
  final response = await http.post(Uri.parse(createProductEndPoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1|LxkWNBprHUSUhOkANcKTj0H1vvQt1uicjZJc6Nzo'
      },
      body: jsonEncode(product.toJson()));

  if (response.statusCode == 200) {
    
    final responseData = json.decode(response.body);
    final productData = responseData['product'];
    print(response.body);
    return Product.fromJson(productData);
  } else {
    throw Exception('Failed to create product');
  }
}
/*
  static Future<Product> updateProduct(Product product) async {
    final response = await http.put(Uri.parse('$baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return Product.fromJson(jsonData);
    } else {
      throw Exception('Failed to update product');
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }*/
}
