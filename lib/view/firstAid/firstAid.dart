import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class FirstAid extends StatefulWidget {
  const FirstAid({super.key});

  @override
  State<FirstAid> createState() => _FirstAidState();
}

class _FirstAidState extends State<FirstAid> {
  String? aioutput = "";
  late TextEditingController textController;
  File? image;
  final Gemini gemini = Gemini.instance;
  bool isGenerating = false;

  askAiHTtp()async{
    
  }
  askAi() async {
    gemini.textAndImage(
      text: textController.text,
      images: [image!.readAsBytesSync()],
    ).then((value) {
      print(value);
    });
  }

  askAiText() {
    setState(() {
      isGenerating = true;
    });
    gemini.text(textController.text).then((value) {
      print(value);
      setState(() {
        aioutput = value!.content!.parts!.first.text;
        isGenerating = false;
      });
    });
  }

  // imageOptions

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.1),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, size.height * 0.06, 20, 20),
          decoration: topBarDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'First Aid',
                    style: heading.copyWith(color: Colors.white, fontSize: 28),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Text(
                          'ESC',
                          style: smallText.copyWith(
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.close,
                          size: 15,
                          color: Colors.white.withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Basic first aid tips or ask AI',
                style: smallTextWhite,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: isGenerating
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isGenerating
                    ? SizedBox(
                        height: size.height * 0.5,
                        child: Center(
                          child: Image.asset('assets/ailoader.gif'),
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 10),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  aioutput = "";
                                  textController.clear();
                                });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Clear',
                                    style: smallText,
                                  ),
                                  Icon(
                                    Icons.close,
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: MarkdownBody(data: aioutput!),
                          ),
                        ],
                      ),
                // Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     child: Text(aioutput!)),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: containerDecoration.copyWith(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor.withOpacity(0.3)),
                  child: TextField(
                    cursorColor: primaryColor,
                    controller: textController,
                    style: smallText.copyWith(color: primaryColor),
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Ask your query",
                        hintStyle: smallText.copyWith(color: primaryColor)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: askAiText,
                child: const Text(
                  'Ask AI',
                  style: smallTextWhite,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
