import 'package:flutter/material.dart';
import 'package:flutter_application_1/profileScreens/accountTile.dart';
import 'package:flutter_application_1/profileScreens/editProfileScreen.dart';
import 'package:flutter_application_1/profileScreens/userProfileStless.dart';
import 'package:flutter_application_1/view/NewsScreens/InterestPage.dart';

class MainSettingsScreen extends StatefulWidget {
  @override
  _SettingsScreen2 createState() => _SettingsScreen2();
}

class _SettingsScreen2 extends State<MainSettingsScreen> {
  bool _isNotificationsEnabled = false;

  void _toggleNotifications(bool value) {
    setState(() {
      _isNotificationsEnabled = value;
      // TODO: Integrate notification enabling/disabling logic here !!!!!!!! TODO
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Personal Information'),
          backgroundColor: Colors.grey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfileView(
              name: 'John Doe',
              email: 'johndoe@example.com',
              imageUrl: 'https://via.placeholder.com/150',
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 7),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Connected Accounts',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    AccountTile(
                      name: 'X',
                      leadingIcon: Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Image.asset("resimler/x_logo.jpg",
                            height: 30, fit: BoxFit.cover),
                      ),
                    ),
                    AccountTile(
                      name: 'Google',
                      leadingIcon: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    AccountTile(
                      name: 'Apple',
                      leadingIcon: Icon(Icons.apple, size: 30),
                      initiallyConnected: true,
                    ),
                    AccountTile(
                      name: 'Facebook',
                      leadingIcon: Icon(Icons.facebook, size: 30),
                    ),
                  ],
                ),
              ),
            ),
            SwitchListTile(
              title: Text('Notifications'),
              value: _isNotificationsEnabled,
              onChanged: _toggleNotifications,
              secondary: Icon(_isNotificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off),
            ),
            ListTile(
              title: Text('Preferences'),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InterestsScreen()),
                  );
                },
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              title: Text('Settings'),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditSettingsScreen()),
                  );
                },
                child: Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
