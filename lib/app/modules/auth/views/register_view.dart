import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth.dart';

class RegisterView extends GetView<Auth> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Account',
          style: theme.textTheme.labelLarge,
        ),
        foregroundColor: theme.scaffoldBackgroundColor,
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller.emailController,
                'Email',
                'Enter a valid email',
                TextInputType.emailAddress,
              ),
              _buildTextField(
                controller.fnameController,
                'First Name',
                'First name is required',
              ),
              _buildTextField(
                controller.lnameController,
                'Last Name',
                'Last name is required',
              ),
              _buildTextField(
                controller.mnameController,
                'Middle Name (Optional)',
                null,
              ),
              _buildDateField(
                controller.dobController,
                'Date of Birth',
                'Required',
              ),
              _buildTextField(
                controller.contactController,
                'Contact Number',
                'Contact number is required',
                TextInputType.phone,
              ),
              const SizedBox(height: 10),
              const Text('Gender',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              Obx(() => DropdownButtonFormField<String>(
                    initialValue: controller.selectedGender.value.isEmpty
                        ? null
                        : controller.selectedGender.value,
                    hint: const Text('Select Gender'),
                    items: ['male', 'female']
                        .map((g) => DropdownMenuItem(
                              value: g, // lowercase value
                              child: Text(
                                  g.capitalizeFirst!), // display capitalized
                            ))
                        .toList(),
                    onChanged: (val) =>
                        controller.selectedGender.value = val ?? '',
                    validator: (val) => val == null || val.isEmpty
                        ? 'Gender is required'
                        : null,
                  )),
              const SizedBox(height: 10),
              _buildTextField(
                controller.passwordController,
                'Password',
                'Password is required',
                TextInputType.visiblePassword,
                true,
              ),
              _buildTextField(
                controller.addressController,
                'Address',
                'Address is required',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text('Register', style: theme.textTheme.labelMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String? validatorMsg, [
    TextInputType type = TextInputType.text,
    bool obscure = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscure,
        validator: validatorMsg != null
            ? (value) => value!.trim().isEmpty ? validatorMsg : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

Widget _buildDateField(
  TextEditingController controller,
  String label,
  String? validatorMsg,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(
      controller: controller,
      readOnly: true, // prevent keyboard
      validator: (value) =>
          value!.trim().isEmpty ? validatorMsg ?? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final now = DateTime.now();
        final DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime(now.year - 18), // default 18 years ago
          firstDate: DateTime(1900),
          lastDate: DateTime(now.year, now.month, now.day),
        );

        if (pickedDate != null) {
          controller.text =
              pickedDate.toIso8601String().split('T')[0]; // YYYY-MM-DD
        }
      },
    ),
  );
}
