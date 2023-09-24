import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:storage_guard_dashboard/pages/create_product.dart';
import '../constant/network.dart';
import '../models/cloned_product.dart';
import '../models/product.dart';
import '../services/clone_product_service.dart';
import '../services/product_service.dart';

class CreateProductController extends GetxController {

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getALLClonedProducts();
  }
  var anchor;
  var id;

  int productIndex = -1;

  selectItem(index){
    productIndex = index;
    update();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController productionDateController =
  TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController minTempController = TextEditingController();
  final TextEditingController maxTempController = TextEditingController();
  final TextEditingController minHumController = TextEditingController();
  final TextEditingController maxHumController = TextEditingController();
  final TextEditingController countProduct = TextEditingController();
  List<bool> isSelected = [true,false,false];
  void chooseType(int index){
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    update();
  }

  List<ClonedProduct> clonedProductId = [];
  List<Product> clonedProduct = [];
  Future<void> getALLClonedProducts() async {
    clonedProductId = await ClonedProductService.getClonedProducts(1);
    for (var element in clonedProductId){
      clonedProduct.add(await ProductService.getProduct(element.newProduct));
    }
    update();
  }

  Future<int> createProduct() async {
    try {
      final product = Product(
        name: nameController.text,
        description: descriptionController.text,
        productionDate: productionDateController.text,
        expiryDate: expiryDateController.text,
        maxTemperature: double.parse(maxTempController.text),
        minTemperature: double.parse(minTempController.text),
        maxHumidity: double.parse(maxHumController.text),
        minHumidity: double.parse(minHumController.text),
      );

      var response = await ProductService.createProduct(product);

      Get.snackbar(
        'Success',
        'Product created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return response.id!;
      // Product creation successful
      // Navigate to the next screen or show a success message
    } catch (e) {
      Get.snackbar(
        'Error',
        'Product creation failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Product creation failed
      // Show an error message
      print('Error creating product: $e');
      return 0;
    }
  }
  pw.Document generatePdf(int count, String data) {
    // Calculate the number of pages needed to display all the QR codes
    int pageCount = (count / 16).ceil();

    // Create a new PDF document
    final pdf = pw.Document(title: "Storage Guard Qr code");

    // Generate the QR codes and add them to the document
    for (int page = 0; page < pageCount; page++) {
      // Create a new page
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // Create a grid of QR codes for this page
          List<pw.Widget> qrCodes = [];
          int startIndex = page * 16;
          int endIndex = (page + 1) * 16;
          if (endIndex > count) {
            endIndex = count;
          }
          for (int i = startIndex; i < endIndex; i++) {
            // Create the QR code widget

            // Add the QR code widget to the list
            qrCodes.add(pw.BarcodeWidget(
              width: 60,
              height: 60,
              barcode: pw.Barcode.qrCode(),
              data: data,
            ));
          }

          // Create a grid layout for the QR codes
          final qrCodeGrid = pw.GridView(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            children: qrCodes,
          );

          // Create a container to center the grid layout on the page
          final center = pw.Center(
            child: pw.Container(
              child: qrCodeGrid,
            ),
          );

          return center;
        },
      ));
    }
    // Return the generated document
    return pdf;
  }
  pw.Document generateProductsPdf(int count, List<String> data) {

    int pageCount = (count / 16).ceil();

    // Create a new PDF document
    final pdf = pw.Document(title: "Storage Guard Qr code");

    // Generate the QR codes and add them to the document
    for (int page = 0; page < pageCount; page++) {
      // Create a new page
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // Create a grid of QR codes for this page
          List<pw.Widget> qrCodes = [];
          int startIndex = page * 16;
          int endIndex = (page + 1) * 16;
          if (endIndex > count) {
            endIndex = count;
          }
          for (int i = startIndex; i < endIndex; i++) {
            // Create the QR code widget

            // Add the QR code widget to the list
            qrCodes.add(pw.BarcodeWidget(
              width: 60,
              height: 60,
              barcode: pw.Barcode.qrCode(),
              data: data[i],
            ));
          }

          // Create a grid layout for the QR codes
          final qrCodeGrid = pw.GridView(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            children: qrCodes,
          );

          // Create a container to center the grid layout on the page
          final center = pw.Center(
            child: pw.Container(
              child: qrCodeGrid,
            ),
          );

          return center;
        },
      ));
    }

    // Return the generated document
    return pdf;
  }

  createPDF(int count,id,bool user) async {
    final pdf = user?generatePdf(count, "StorageGuard User :$id"):generatePdf(count, "StorageGuard Product :$id");
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'Storage Guard QRCode.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
  }
  createProductPDF(List<int> idList) async {
    int count = idList.length;
    List<String> data = [];
    for (var i in idList){
      data.add("StorageGuard Product :$i");
    }
    final pdf = generateProductsPdf(count,data);
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'Storage Guard QRCode.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
  }


  Future<void> onPressed() async{
    List<int> idList = [];
    if(isSelected.indexOf(true) == 0) {
      for (int i=0;i<int.parse(countProduct.text);i++){
      await createProduct().then((value) => idList.add(value.toInt()));
    }}
    if (idList.isNotEmpty) {
      createProductPDF(idList);
    }
    else if(isSelected.indexOf(true) == 1){
    await createPDF(int.parse(
    countProduct.text,
    ),1,true);}
  }
}
