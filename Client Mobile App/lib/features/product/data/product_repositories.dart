import 'package:dartz/dartz.dart';
import 'package:storage_guard/core/error/failures.dart';
import 'package:storage_guard/core/network/repositories.dart';
import 'package:storage_guard/features/product/data/product_datasource.dart';

import 'product_model.dart';

class ProductRepositories {
  ProductRepositories(this._productDataSource);
  final ProductDataSource _productDataSource;
  Future<Either<Failure, ProductModel>> getProduct(int productId) async =>
      await repository(() => _productDataSource.getProduct(productId));
  Future<Either<Failure, ProductModel>> createClonedProduct(
          int productId) async =>
      await repository(() => _productDataSource.createClonedProduct(productId));
}
