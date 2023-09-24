import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storage_guard_dashboard/widgets/text_area.dart';
import 'package:storage_guard_dashboard/widgets/text_field_date.dart';
import 'package:storage_guard_dashboard/widgets/text_fields.dart';

import '../constant/textstyle.dart';

class CreateProduct extends StatelessWidget {


  final TextEditingController nameController;
  final TextEditingController descriptionController ;
  final TextEditingController productionDateController ;
  final TextEditingController expiryDateController ;
  final TextEditingController minTempController ;
  final TextEditingController maxTempController ;
  final TextEditingController minHumController ;
  final TextEditingController maxHumController ;
  final TextEditingController countProduct ;

  const CreateProduct({super.key, required this.nameController, required this.descriptionController, required this.productionDateController, required this.expiryDateController, required this.minTempController, required this.maxTempController, required this.minHumController, required this.maxHumController, required this.countProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Product Name",
            style: TextStyles.bodyTextStyle,
          ),
          SizedBox(height: 4.h),
          CircularTextField(
              hintText: "Type here", controller: nameController),
          SizedBox(height: 16.h),
          Text(
            "Product Description",
            style: TextStyles.bodyTextStyle,
          ),
          SizedBox(height: 4.h),
          CircularTextArea(
              hintText: "Type here",
              controller: descriptionController),
          SizedBox(height: 16.h),
          Text(
            "Production Date",
            style: TextStyles.bodyTextStyle,
          ),
          SizedBox(height: 4.h),
          CircularTextFieldDate(
              hintText: "Production Date",
              controller: productionDateController),
          SizedBox(height: 16.h),
          Text(
            "Expiry Date",
            style: TextStyles.bodyTextStyle,
          ),
          SizedBox(height: 4.h),
          CircularTextFieldDate(
              hintText: "Expiry Date",
              controller: expiryDateController),
          SizedBox(height: 16.h),
          Text(
            "Temperature Range",
            style: TextStyles.bodyTextStyle,
          ),
          SizedBox(height: 4.h),
          Row(children: [
            Expanded(
                child: CircularTextField(
                  hintText: "Min",
                  controller: minTempController,
                )),
            SizedBox(width: 5.w),
            Expanded(
                child: CircularTextField(
                  hintText: "Max",
                  controller: maxTempController,
                )),
          ]),
          SizedBox(height: 16.h),
          Text(
            "Humidity Range",
            style: TextStyles.bodyTextStyle,
          ),
          SizedBox(height: 4.h),
          Row(children: [
            Expanded(
                child: CircularTextField(
                  hintText: "Min",
                  controller: minHumController,
                )),
            SizedBox(width: 5.w),
            Expanded(
                child: CircularTextField(
                  hintText: "Max",
                  controller: maxHumController,
                )),
          ]),
        ],
      ),
    );

  }
}



