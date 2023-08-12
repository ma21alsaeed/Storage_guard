import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:storage_guard_dashboard/models/operation.dart';
import '../constant/network.dart';
import '../models/sensor_data.dart';


class OperationService {

  static Future<List<OperationData>> getOperations() async {
    final response = await http.get(Uri.parse(getAllOperationsEndPoint),
  headers: {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer 5|pE2emCFxygxrEk9sK2rlULcSmkwKVm6SO0dkHHVq'
  },);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)["data"];
      print(jsonData);
      return jsonData.map((operation) => OperationData.fromJson(operation)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load Operation');
    }
  }


  static Future<List<SensorData>> getSensorReadings(int id) async {
    final response = await http.get(Uri.parse(getAllSensorDataEndPoint+id.toString()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 5|pE2emCFxygxrEk9sK2rlULcSmkwKVm6SO0dkHHVq'
      },);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)["data"];
      print(jsonData);
      return jsonData.map((operation) => SensorData.fromJson(operation)).toList();
      
    } else {
      print(response.body);
      throw Exception('Failed to load Operation');
    }
  }
/*
  static Future<Product> getProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return Product.fromJson(jsonData);
    } else {
      throw Exception('Failed to load product');
    }
  }

 static Future<Operation> createProduct(Operation product) async {
    final response = await http.post(Uri.parse(createProdcutEndPoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer 18|rFaeNPYcI817WRkFk0Jl7mYRff8HXX1EHQjOMY13'
        },
        body: jsonEncode(product.toJson()));

    if (response.statusCode == 200) {

      final responseData = json.decode(response.body);
      final productData = responseData['data'];
      print(response.body);
      return Operation.fromJson(productData);
    } else {
      throw Exception('Failed to create product');
    }
  }
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
