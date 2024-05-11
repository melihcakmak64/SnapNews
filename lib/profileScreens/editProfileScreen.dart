import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profileController.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/profileScreens/userProfileStful.dart';
import 'package:get/get.dart';

class EditSettingsScreen extends StatelessWidget {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController =
        TextEditingController(text: profileController.name.value);
    TextEditingController _emailController =
        TextEditingController(text: profileController.email.value);
    TextEditingController _passwordController =
        TextEditingController(text: profileController.password.value);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => UserProfileEdit(
                name: profileController.name.value,
                email: profileController.email.value,
              ),
            ),
            _editableListTile(context, 'Name', _nameController, Icons.person,
                (value) {
              profileController.name.value = _nameController.text;
            }),
            _editableListTile(context, 'Email', _emailController, Icons.email,
                (value) {
              profileController.email.value = _emailController.text;
            }),
            _editableListTile(
              context,
              'Password',
              _passwordController,
              Icons.lock,
              (value) {
                profileController.password.value = _passwordController.text;
              },
              isPassword: true,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                profileController.updateProfile();
              },
              child: Text('Update Information'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editableListTile(
    BuildContext context,
    String label,
    TextEditingController controller,
    IconData icon,
    void Function(String)? onChanged, {
    bool isPassword = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        obscureText: isPassword,
        onChanged: onChanged,
      ),
    );
  }
}
