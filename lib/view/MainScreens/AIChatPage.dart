import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/aiChatWidget.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// news api key fdc847a945174558b58c08dcff436349

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  List<String> listDatas = [];
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'SnapNews AI Chatbot',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          listDatas.isEmpty
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'images/ai_logo.png',
                          width: 60,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "How can I help you?",
                          style: Theme.of(context).textTheme.headlineMedium!,
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemCount: listDatas.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Align(
                        alignment: index.isOdd
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              listDatas[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: index.isOdd
                                        ? Color.fromARGB(255, 0, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (BuildContext context, dynamic value, Widget? child) {
              if (!value) {
                return const SizedBox();
              }
              return const SpinKitThreeBounce(
                color: Colors.blue,
                size: 30,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onEditingComplete: () async {
                      _searchContent();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter a Prompt ...",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    if (value) {
                      return const CircularProgressIndicator(
                        color: Colors.blue,
                      );
                    }
                    return InkWell(
                      onTap: () async {
                        await _searchContent();
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _searchContent() async {
    if (controller.text.isNotEmpty) {
      listDatas.add(controller.text);

      isLoading.value = true;

      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: "AIzaSyAQy7pghDRagRCMCfSkIjVcjLy4idzShkc",
      );

      final prompt = controller.text;
      final content = [Content.text(prompt)];
      controller.clear();
      final response = await model.generateContent(content);

      listDatas.add(response.text ?? "");

      isLoading.value = false;

      controller.clear();
    }
    setState(() {});
  }
}
