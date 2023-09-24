import 'package:http/http.dart';
import 'package:storage_guard/core/network/data_source.dart';
import 'package:storage_guard/core/network/urls.dart';
import 'package:storage_guard/features/shop/data/shop_model.dart';

class ShopDataSource {
  ShopDataSource(this._client);
  final Client _client;
  Future<ShopModel> getShop(int userId) async => await dataSource(
      () => _client
          .get(Uri.parse(shopUrl(userId)), headers: {'Accept': 'application/json'}),
      model: shopModelFromJson);
}
