import 'package:deneme_uygulama/profile/userProfileStful.dart';
import 'package:flutter/material.dart';

class EditSettingsScreen extends StatefulWidget {
  @override
  _EditSettingsScreenState createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _updateProfile() {
    // Implement the logic to update the profile here
    _toggleEditing(); // Turn off editing mode after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfileEdit(
                name: _nameController.text, email: _emailController.text),
            _editableListTile(
              context,
              'Name',
              _nameController,
              Icons.person,
            ),
            _editableListTile(
              context,
              'Email',
              _emailController,
              Icons.email,
            ),
            _editableListTile(
              context,
              'Password',
              _passwordController,
              Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 10.0),
            if (_isEditing)
              ElevatedButton(
                onPressed: _updateProfile,
                child: Container(
                    color: Colors.grey[300], child: Text('Update Information')),
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
    IconData icon, {
    bool isPassword = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: _isEditing
          ? TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: label),
              obscureText: isPassword,
              readOnly: !_isEditing,
            )
          : Text('$label: ${controller.text}'),
      trailing: Icon(Icons.edit),
      onTap: () {
        if (!_isEditing) {
          _toggleEditing();
        }
      },
    );
  }
}
