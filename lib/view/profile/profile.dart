import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/controllers/userController.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/functions.dart';
import 'package:quickcare_user/utils/shimmers.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker picker = ImagePicker();
  File? image;
  bool isLoading = false;
  bool isUploading = false;
  String profilePic = "";
  UserController userController = UserController();
  String? userId = '';
  double uploadProgress = 0;
  String dowloadUrl = '';
  Map<String, dynamic> userData = {};
  fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    userId = await SF.getUserId();
    await userController.getUserDetails(userId: userId!).then((value) {
      setState(() {
        userData = jsonDecode(value);
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      image = File(pickedFile!.path);
    });
    previewPopUp(image);
  }

  uploadImage() async {
    setState(() {
      isUploading = true;
    });
    FirebaseStorage.instance
        .ref('${userData["firstName"]}-$userId/profilePic/${image!.path}')
        .putFile(image!)
        .snapshotEvents
        .listen((event) async {
      // save the progress
      setState(() {
        uploadProgress =
            (event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                100;
      });
      if (event.state == TaskState.success) {
        successToast(message: 'File added to the library');
        setState(() {
          isUploading = false;
          uploadProgress = 0;
        });

        dowloadUrl = await FirebaseStorage.instance
            .ref('${userData["firstName"]}-$userId/profilePic/${image!.path}')
            .getDownloadURL();
        setState(() {
          profilePic = dowloadUrl;
        });
        userController
            .updateProfilePic(profilePhotoLink: profilePic, userId: userId!)
            .whenComplete(() {
          fetchUserData();
        });
      }
      print(uploadProgress);
      print(profilePic);
    });
  }

  previewPopUp(File? image) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.file(image!),
            actions: [
              TextButton(
                  onPressed: () {
                    uploadImage();
                    Navigator.pop(context);
                  },
                  child: Text(isUploading ? "Uploading" : 'Upload'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.fromLTRB(20, size.height * 0.06, 20, 20),
                    decoration: topBarDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Profile',
                              style: heading.copyWith(
                                  color: Colors.white, fontSize: 28),
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
                        const SizedBox(height: 15),
                        const Text(
                          'See your profile and your past activity...',
                          style: smallTextWhite,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  isUploading
                      ? Column(
                          children: [
                            Text('Uploaded - $uploadProgress%'),
                            LinearProgressIndicator(
                              value: uploadProgress.clamp(
                                  0.0, 1.0), // Clamp the value to [0.0, 1.0]
                            )
                          ],
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isLoading
                                    ? const ShimmerText(width: 250, height: 50)
                                    : Text(
                                        '${userData['firstName']} ${userData['lastName']}',
                                        style: heading),
                                isLoading
                                    ? const ShimmerText(width: 100, height: 15)
                                    : Text(
                                        'Since ${getMonthAndYear(userData['createdAt'])}',
                                        style: smallText),
                              ],
                            ),
                            isLoading
                                ? const ShimmerCircle()
                                : GestureDetector(
                                    onTap: () {
                                      pickImage();
                                    },
                                    child: userData["profilePicture"] != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  userData['profilePicture'],
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.all(22),
                                            decoration: BoxDecoration(
                                                color: primaryColor
                                                    .withOpacity(0.2),
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                                'assets/icons/person.png',
                                                color: primaryColor,
                                                scale: 7.5),
                                          ),
                                  )
                          ],
                        ),
                        const SizedBox(height: 20),
                        isLoading
                            ? const ShimmerIconLabel()
                            : Row(
                                children: [
                                  const IconBox(
                                      icon: 'assets/icons/call_outline.png'),
                                  const SizedBox(width: 15),
                                  Text('+91 ${userData['phoneNum']}',
                                      style: smallText),
                                ],
                              ),
                        const SizedBox(height: 10),
                        isLoading
                            ? const ShimmerIconLabel()
                            : Row(
                                children: [
                                  const IconBox(
                                      icon: 'assets/icons/location.png'),
                                  const SizedBox(width: 15),
                                  SizedBox(
                                      width: size.width * 0.6,
                                      child: Text('${userData['address']}',
                                          style: smallText)),
                                ],
                              ),
                        const SizedBox(height: 10),
                        isLoading
                            ? const ShimmerIconLabel()
                            : Row(
                                children: [
                                  const IconBox(icon: 'assets/icons/mail.png'),
                                  const SizedBox(width: 15),
                                  Text('${userData['email']}',
                                      style: smallText),
                                ],
                              ),
                        const SizedBox(height: 10),
                        isLoading
                            ? const ShimmerIconLabel()
                            : Row(
                                children: [
                                  const IconBox(icon: 'assets/icons/work.png'),
                                  const SizedBox(width: 15),
                                  Text('${userData['uniqueOrgCode']}',
                                      style: smallText),
                                ],
                              ),
                        const Divider(
                          color: primaryColor,
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Past Bookings',
                          style: heading.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const IconBox(icon: 'assets/icons/tick.png'),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: containerDecoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('09-10-2023',
                                        style: normalTextBold.copyWith(
                                            fontSize: 12)),
                                    const Text('Issue Faced', style: smallText),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(icon: 'assets/icons/eye.png'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const IconBox(icon: 'assets/icons/cross.png'),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: containerDecoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('09-10-2023',
                                        style: normalTextBold.copyWith(
                                            fontSize: 12)),
                                    const Text('Issue Faced', style: smallText),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(icon: 'assets/icons/eye.png'),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.settings);
        },
        child: SizedBox(
          width: 25,
          child: Image.asset('assets/icons/settings.png'),
        ),
      ),
    );
  }
}
