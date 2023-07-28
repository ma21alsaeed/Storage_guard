import 'package:dartz/dartz.dart';
import 'package:storage_guard/core/error/failures.dart';
import 'package:storage_guard/core/network/repositories.dart';
import 'package:storage_guard/features/shop/data/shop_datasource.dart';
import 'package:storage_guard/features/shop/data/shop_model.dart';

class ShopRepositories {
  ShopRepositories(this._shopDataSource);
  final ShopDataSource _shopDataSource;
  Future<Either<Failure, ShopModel>> getshop(String url) async =>
      await repository(() => _shopDataSource.getshop(url));
}
