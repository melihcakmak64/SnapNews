import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationsEnabled = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEditing = false;

  File? _image;

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _image = File(returnedImage.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _updateProfile() {
    if (_isEditing) {
      // TODO: Implement profile update logic
      // For example, send _nameController.text, _emailController.text, and _passwordController.text to your database
    }

    _toggleEditing(); // Toggle editing state
  }

  // Simulate fetching data from a database
  Future<void> _fetchUserData() async {
    // TODO: Fetch user data from your database and assign the values to below variables
    final String nameFromDb = 'John Doe'; // Simulated name
    final String emailFromDb = 'johndoe@example.com'; // Simulated email
    final String passwordFromDb = 'password123'; // Simulated password

    setState(() {
      _nameController.text = nameFromDb;
      _emailController.text = emailFromDb;
      _passwordController.text = ''; // use dummy data
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    double screenWidth = screenSize.size.width;
    double screenHeight = screenSize.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: screenWidth / 12),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 10),
                child: Text(
                  "Personal Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: screenWidth / 15),
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_isEditing) {
                      _pickImageFromGallery();
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!.path))
                            as ImageProvider // Display the picked image.
                        : NetworkImage(
                            'https://www.freepik.com/premium-vector/people-profile-graphic_2757319.htm'), // Placeholder image
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Name field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        readOnly:
                            !_isEditing, // Make it read-only if not editing
                      ),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        readOnly:
                            !_isEditing, // Make it read-only if not editing
                      ),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        readOnly:
                            !_isEditing, // Make it read-only if not editing
                        // Note: You might not want to allow password viewing/editing for security
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        child: Text(
                            _isEditing ? 'Update Information' : 'Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          ListTile(
            title: Text('Notifications'),
            trailing: Checkbox(
              value: isNotificationsEnabled,
              onChanged: (bool? value) {
                setState(() {
                  isNotificationsEnabled = value ?? false;
                });
              },
            ),
          ),
          SizedBox(height: 25),
          ListTile(
            title: Text('Preferences'),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // TODO: Implement navigation to preferences
              },
            ),
          ),
        ],
      ),
    );
  }
}
