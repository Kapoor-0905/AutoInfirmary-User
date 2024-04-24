import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/controllers/userController.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/shimmers.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/view/home/components/menuTile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserController userController = UserController();
  String? userId = '';
  String? session = '';
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  bool hasProfilePicture = false;

  fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    userId = await SF.getUserId();
    session = await SF.getSessionToken();
    print(userId);
    print(session);
    await userController.getUserDetails(userId: userId!).then((value) {
      setState(() {
        userData = jsonDecode(value);

        isLoading = false;
      });
      userData.containsKey('profilePicture')
          ? setState(() {
              hasProfilePicture = true;
            })
          : null;
    });

    print(session);
    // await AppointmentBookingController().getAppointmentBookings().then((value) {
    //   print(value);
    // });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, size.height * 0.05, 20, 20),
            decoration: topBarDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'QuickCare',
                      style:
                          heading.copyWith(color: Colors.white, fontSize: 28),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.profile);
                      },
                      child: isLoading
                          ? ShimmerCircle()
                          : userData["profilePicture"] != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      userData['profilePicture'],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      shape: BoxShape.circle),
                                  child: Image.asset('assets/icons/person.png',
                                      scale: 9.5),
                                ),
                    ),
                  ],
                ),
                isLoading
                    ? const ShimmerText(
                        width: 200,
                      )
                    : Text(
                        'Hi ${userData['firstName']} !',
                        style: bigTextWhite,
                      ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Are you feeling well?',
                      style: smallTextBold.copyWith(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, RouteNames.bookAppointment,
                          arguments: userData),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 6,
                              spreadRadius: 1,
                              offset: const Offset(0, 0),
                            )
                          ],
                        ),
                        child: Text(
                          'Book Appointment',
                          style: smallTextWhite.copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isLoading
                        ? const ShimmerText(
                            width: 70,
                          )
                        : Text(
                            '${userData['uniqueOrgCode']}',
                            style: smallTextWhite,
                          ),
                    isLoading
                        ? const ShimmerText(
                            width: 100,
                          )
                        : Text.rich(
                            TextSpan(
                              text: 'Status: ',
                              style: smallTextWhite,
                              children: [
                                TextSpan(
                                  text: 'Open',
                                  style: smallTextWhite.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: roundedContainerDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: size.width * 0.3,
                          child: Image.asset('assets/images/queue.png')),
                      Column(
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: const Text(
                              'Bookings in 9:00 to 10:00',
                              textAlign: TextAlign.center,
                              style: normalTextBold,
                            ),
                          ),
                          const Text(
                            '5 Bookings',
                            style: smallText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuTile(
                      arguments: userData,
                      route: RouteNames.emergencyBooking,
                      displayImage: 'assets/images/emergency.png',
                      displayText: 'Emergency',
                    ),
                    MenuTile(
                      arguments: userData,
                      route: RouteNames.bookAppointment,
                      displayImage: 'assets/images/bookingappointment.png',
                      displayText: 'Book Appointment',
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuTile(
                      route: RouteNames.firstAid,
                      displayImage: 'assets/images/first_aid.png',
                      displayText: 'First Aid',
                      scale: 5,
                    ),
                    MenuTile(
                      route: RouteNames.emergencyContacts,
                      displayImage: 'assets/images/emergency_contacts.png',
                      displayText: 'Emergency Contacts',
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
