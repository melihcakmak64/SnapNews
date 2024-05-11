// En üstte duracak olan widget.
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profileController.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileEdit extends StatefulWidget {
  final String name;
  final String email;

  UserProfileEdit({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  File? _image;
  ProfileController _profileController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? returnedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _image = File(returnedImage.path);
    });

    // Resmi yükle ve kullanıcı modelini güncelle
    await _profileController.uploadImageAndUpdateProfile(_image!);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    return InkWell(
      onTap: _pickImageFromGallery,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 7),
        child: Container(
          width: screenHeight / 2,
          height: screenHeight / 4,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(119, 0, 0, 0),
                  blurRadius: 80,
                  offset: Offset(0, 50),
                ),
              ]),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 115.0),
                    child: Column(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.email,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -30, // Change position in Y axis
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                              as ImageProvider // Display the picked image
                          : NetworkImage(_profileController
                                      .userModel.profileURL ==
                                  ""
                              ? 'https://via.placeholder.com/150'
                              : _profileController.userModel
                                  .profileURL!), // Default placeholder image
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
