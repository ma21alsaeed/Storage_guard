part of 'product_cubit.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class LoadingState extends ProductState {}

class GotProduct extends ProductState {
  final ProductModel product;

  GotProduct(this.product);
}

class ErrorState extends ProductState {
  final String message;

  ErrorState(this.message);
}
