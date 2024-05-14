import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profileController.dart';

import 'package:flutter_application_1/profileScreens/userProfileStless.dart';

import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Personal Information'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 7),
          child: Column(
            children: [
              Obx(() => UserProfileView(
                    name: _profileController.name.value,
                    email: _profileController.email.value,
                    imageUrl: _profileController.imageUrl.value,
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: _profileController.goToEditProfile,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 17.0,
                                right: 234,
                              ),
                              child: Text(
                                'Settings',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Icon(Icons.settings),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _profileController.logOut,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 17.0,
                                right: 245,
                              ),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Icon(Icons.logout),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
