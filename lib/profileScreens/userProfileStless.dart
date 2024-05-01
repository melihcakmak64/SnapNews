import 'package:flutter/material.dart';

// Bu ekran ayarlar düzenlenmeyecekse kullanılmayacak. Sadece görünüm olarak kullanılır.

class UserProfileView extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  UserProfileView({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    return Padding(
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
              offset: Offset(0, 100),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 115.0),
                  child: Container(
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  ),
                ),
                Positioned(
                  top: -30, // Change position in Y axis
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage(imageUrl), // Dynamic image URL
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
