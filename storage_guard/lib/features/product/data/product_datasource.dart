import 'package:http/http.dart';
import 'package:storage_guard/core/network/data_source.dart';
import 'package:storage_guard/core/network/urls.dart';
import 'package:storage_guard/features/product/data/product_model.dart';

class ProductDataSource {
  ProductDataSource(this._client);
  final Client _client;
  Future<ProductModel> getProduct(int productId) async => await dataSource(
      () => _client.get(Uri.parse(productUrl(productId)),
          headers: {'Accept': 'application/json'}),
      model: productModelFromJson);
}
