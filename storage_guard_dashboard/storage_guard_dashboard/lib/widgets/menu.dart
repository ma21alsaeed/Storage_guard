import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../pages/create_product.dart';
import 'storage_guard_title.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.purple50,
            ),
            child: StorageGuardTitle()
            
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigate to the home page
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Create New Product'),
            onTap: () {
              // Navigate to the home page
              Get.to(()=>CreateQRCode());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to the settings page
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
