import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile.dart';
import '../views/map_picker_view.dart';
import '../../../config/asset_routes.dart';

class ProfileView extends GetView<Profile> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.openMedia();
                  },
                  child: Obx(
                    () => CircleAvatar(
                      radius: 60,
                      backgroundColor: theme.colorScheme.primary.withAlpha(25),
                      backgroundImage: controller.imageFile.value != null
                          ? FileImage(controller.imageFile.value!)
                          : controller.profileImagePath.value == null
                              ? const AssetImage(
                                      'assets/img/avatars/avatar-placeholder.png')
                                  as ImageProvider
                              : NetworkImage(
                                      '${AssetRoutes.userProfile}${controller.profileImagePath.value!}')
                                  as ImageProvider,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🧾 Input fields
            _buildTextField(
                controller.fnameController, 'First Name', Icons.person_outline),
            _buildTextField(controller.mnameController, 'Middle Name',
                Icons.badge_outlined),
            _buildTextField(
                controller.lnameController, 'Last Name', Icons.person),
            _buildTextField(
              keyboardType:
                  const TextInputType.numberWithOptions(signed: false),
              controller.contactnoController,
              'Contact No.',
              Icons.phone,
            ),
            GestureDetector(
              onTap: () async {
                final result = await Get.to(() => const MapPickerView());
                if (result != null) {
                  controller.mapLocController.text = result['address'];
                  controller.lat = result['lat'];
                  controller.long = result['lng'];
                }
              },
              child: AbsorbPointer(
                child: _buildTextField(
                  controller.mapLocController,
                  'Map Location',
                  Icons.map,
                ),
              ),
            ),

            _buildTextField(
              controller.addressController,
              'Address',
              Icons.location_on_sharp,
            ),

            // _buildTextField(
            //     controller.emailController, 'Email', Icons.email_outlined,
            //     keyboardType: TextInputType.emailAddress),
            // _buildTextField(
            //     controller.passwordController, 'Password', Icons.lock_outline,
            //     obscureText: true,
            //     hintText: 'Leave blank to keep current password'),

            const SizedBox(height: 30),

            // 💾 Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.updateUser();
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    String? hintText,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}
