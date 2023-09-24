part of 'create_cloned_product_cubit.dart';

abstract class CreateClonedProductState {
  const CreateClonedProductState();
}

class CreateClonedProductInitial extends CreateClonedProductState {}

class LoadingState extends CreateClonedProductState {}

class CreatedClonedProduct extends CreateClonedProductState {
  final ProductModel product;

  CreatedClonedProduct(this.product);
}

class ErrorState extends CreateClonedProductState {
  final String message;

  ErrorState(this.message);
}
