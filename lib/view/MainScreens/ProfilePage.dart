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
                    ListTile(
                      title: const Text('Preferences'),
                      trailing: InkWell(
                        onTap: () =>
                            _profileController.goToInterests("Profile"),
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    ListTile(
                      title: const Text('Settings'),
                      trailing: InkWell(
                        onTap: _profileController.goToEditProfile,
                        child: const Icon(Icons.settings),
                      ),
                    ),
                    ListTile(
                      title: const Text('Log out'),
                      trailing: InkWell(
                        onTap: _profileController.logOut,
                        child: const Icon(Icons.logout),
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
