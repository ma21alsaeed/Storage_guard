import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storage_guard_dashboard/constant/colors.dart';
import 'package:storage_guard_dashboard/widgets/text_button.dart';
import '../constant/textstyle.dart';
import '../controllers/create_product_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/create_product.dart';
import '../widgets/menu.dart';
import '../widgets/qr_code.dart';
import '../widgets/text_fields.dart';
import '../widgets/control_buttons.dart';

class CreateQRCode extends StatelessWidget {
  final CreateProductController productController =
      Get.put(CreateProductController());

  CreateQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(textTitle: "Create QR Code"),
      drawer: AppDrawer(),
      floatingActionButton: GetBuilder<CreateProductController>(
          builder: (controller) => ControlButtons(
              onPressed: (int index) {
                controller.chooseType(index);
              },
              isSelected: controller.isSelected)),
      body: Padding(
        padding:  EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GetBuilder<CreateProductController>(
                        builder: (controller) =>
                            controller.isSelected.indexOf(true) == 0
                                ? Expanded(
                                    child: CreateProduct(
                                      nameController:
                                          productController.nameController,
                                      minTempController:
                                          productController.minTempController,
                                      minHumController:
                                          productController.minHumController,
                                      maxTempController:
                                          productController.maxTempController,
                                      maxHumController:
                                          productController.maxHumController,
                                      countProduct: productController.countProduct,
                                      descriptionController:
                                          productController.descriptionController,
                                      expiryDateController:
                                          productController.expiryDateController,
                                      productionDateController: productController
                                          .productionDateController,
                                    ),
                                  )
                                : controller.isSelected.indexOf(true) == 1?
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.all(30.0.r),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Cloned Products List",style: TextStyles.mediumTextStyle,),
                                        SizedBox(height: 20.h,),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.clonedProduct.length,
                                          itemBuilder: (context, index) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.r),
                                              color: controller.productIndex==index ? Colors.grey.shade200:Colors.grey.shade100
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                title: Text(controller.clonedProduct[index].name),
                                                trailing:
                                                Image.asset("assets/images/safe_icon.png",fit: BoxFit.contain, height: 30.h,),
                                                onTap: (){
                                                  controller.selectItem(index);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ):
                            SizedBox()),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              padding: EdgeInsets.all(30.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: AppColors.lightGray),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Storage Guard QrCode",style:TextStyles.semiTitleTextStyle),
                                  SizedBox(height: 10.h,),
                                  Text(productController.isSelected
                                              .indexOf(true) ==
                                          0|1
                                      ? "Here you can create a QR code for your products"
                                      : "Here you can create a QR code for your account",style:TextStyles.mediumTextStyle,softWrap: true),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const StorageGuardQrCode(data: "StorageGuard Qr Code"),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 200.w,
                                      child: CircularTextField(
                                        hintText: "Products Count",
                                        controller: productController.countProduct,
                                      )),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CircularTextButton(
                                      label: "Print",
                                      onPressed: () async {
                                        await productController.onPressed();
                                      })
                                ])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
