import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String markdownContent = '';
  bool _isVisible = false;
  ScrollController controller = ScrollController();

  Future<void> loadMarkdown() async {
    String markdown = await rootBundle.loadString('assets/pp.md');
    setState(() {
      markdownContent = markdown;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    loadMarkdown();
  }

  @override
  void dispose() {
    // Dispose the listener to prevent memory leaks
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    // Check if the user has scrolled to the top
    if (controller.offset <= controller.position.minScrollExtent) {
      if (_isVisible) {
        // Hide the FAB if it's currently visible
        setState(() {
          _isVisible = false;
        });
      }
    } else {
      if (!_isVisible) {
        // Show the FAB if it's currently invisible
        setState(() {
          _isVisible = true;
        });
      }
    }
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
                    'Privacy Policy',
                    textScaler: TextScaler.noScaling,
                    style: heading.copyWith(color: Colors.white, fontSize: 26),
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
                'Know your privacy and security',
                style: smallTextWhite,
              ),
            ],
          ),
        ),
      ),
      body: Markdown(
        controller: controller,
        data: markdownContent,
        styleSheet: MarkdownStyleSheet(
          p: smallText.copyWith(color: Colors.black),
          h1: heading.copyWith(fontSize: 20),
          h2: heading.copyWith(fontSize: 18),
          h3: heading.copyWith(fontSize: 16),
          h4: heading.copyWith(fontSize: 14),
          h5: heading.copyWith(fontSize: 12),
          h6: heading.copyWith(fontSize: 10),
        ),
      ),
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                // scroll to top
                controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              mini: true,
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
