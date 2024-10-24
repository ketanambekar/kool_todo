import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kool_todo/screens/settings/sections/manage_categories_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Manage Categories'),
            onTap: () {
              Get.to(() => ManageCategoriesScreen());
            },
          ),
        ],
      ),
    );
  }
}
