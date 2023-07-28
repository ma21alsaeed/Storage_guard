import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/shop/data/shop_model.dart';
import 'package:storage_guard/features/shop/data/shop_repositories.dart';
part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final ShopRepositories _shopRepositories;
  ShopCubit(this._shopRepositories) : super(ShopInitial());
  Future<void> getShop(String url) async {
    emit(LoadingState());
    final either = await _shopRepositories.getshop(url);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(GotShop(data));
    });
  }
}
