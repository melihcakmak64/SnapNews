import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/myButton.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: const Text("What are you?",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5)),
          ),
          _myContainer("Explore latest news", "Stay connected & informed"),
          _myContainer("Find trending topics", "Stay ahead and engaged"),
          _myContainer("Be conscious", "Changes are happening every day"),
          _myButton("Get started", () {})
        ],
      )),
    );
  }
}

Widget _myContainer(String header, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 243, 243),
          borderRadius: BorderRadius.circular(25)),
      height: Get.size.height * 0.20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(header,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5)),
            Text(body,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
          ],
        ),
      ),
    ),
  );
}

Widget _myButton(String buttonText, final void Function() onTap) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: Get.size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        )),
      ),
    ),
  );
}
