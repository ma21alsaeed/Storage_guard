import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/network.dart';
import '../models/cloned_product.dart';

class ClonedProductService {
  static Future<List<ClonedProduct>> getClonedProducts(int id) async {
    final response = await http.get(Uri.parse("$getAllClonedProductEndPoint$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1|LxkWNBprHUSUhOkANcKTj0H1vvQt1uicjZJc6Nzo'
      },);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)["cloned_Products"];

      return jsonData.map((products) => ClonedProduct.fromJson(products)).toList();
    } else {
      throw Exception('Failed to load Operation');
    }
  }

}
