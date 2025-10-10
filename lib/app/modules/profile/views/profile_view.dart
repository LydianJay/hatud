import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile.dart';
import '../../../widgets/form_textfield.dart';

class ProfileView extends GetView<Profile> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: theme.textTheme.labelLarge,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: width * 0.95,
              padding: const EdgeInsetsGeometry.all(2),
              margin: const EdgeInsets.only(top: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FormTextfield(
                        label: 'First Name:',
                        controller: controller.fnameController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
