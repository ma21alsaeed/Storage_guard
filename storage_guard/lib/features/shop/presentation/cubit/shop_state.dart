part of 'shop_cubit.dart';


abstract class ShopState {
  const ShopState();
}

class ShopInitial extends ShopState {}

class LoadingState extends ShopState {}

class GotShop extends ShopState {
  final ShopModel shop;

  GotShop(this.shop);
}

class ErrorState extends ShopState {
  final String message;

  ErrorState(this.message);
}
