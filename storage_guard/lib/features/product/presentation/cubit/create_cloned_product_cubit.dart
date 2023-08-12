import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/product/data/product_model.dart';
import 'package:storage_guard/features/product/data/product_repositories.dart';
part 'create_cloned_product_state.dart';

class CreateClonedProductCubit extends Cubit<CreateClonedProductState> {
  final ProductRepositories _productRepositories;
  CreateClonedProductCubit(this._productRepositories) : super(CreateClonedProductInitial());
  Future<void> createClonedProduct(int productId) async {
    print("productId$productId");
    emit(LoadingState());
    final either = await _productRepositories.createClonedProduct(productId);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(CreatedClonedProduct(data));
    });
  }
}
