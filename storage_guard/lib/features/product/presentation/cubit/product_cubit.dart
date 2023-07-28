import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/product/data/product_model.dart';
import 'package:storage_guard/features/product/data/product_repositories.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepositories _productRepositories;
  ProductCubit(this._productRepositories) : super(ProductInitial());
  Future<void> getProduct(String url) async {
    emit(LoadingState());
    final either = await _productRepositories.getProduct(url);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(GotProduct(data));
    });
  }
}
