import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickcare_user/controllers/appointmentBookingController.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/appointmentBooking.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/functions.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final AppointmentBookingController abController =
      AppointmentBookingController();
  List appointmentData = [];
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController departmentController;
  late TextEditingController locationController;
  late TextEditingController issueFacingController;
  late TextEditingController timeController;
  DateTime getVal = DateTime.now();

  bookAppointment() async {
    String? userId = await SF.getUserId();
    AppointmentBooking appointmentBooking = AppointmentBooking(
        userId: userId!,
        fullName: nameController.text,
        email: emailController.text,
        department: departmentController.text,
        location: locationController.text,
        issueFacing: issueFacingController.text,
        bookingDate: getVal.toString());
    await abController
        .bookAppointment(appointmentBooking: appointmentBooking)
        .then((value) {
      if (value.toString().isNotEmpty) {
        setState(() {
          nameController.clear();
          emailController.clear();
          departmentController.clear();
          locationController.clear();
          issueFacingController.clear();
          timeController.clear();
        });
        successToast(message: 'Appointment Booked successfully');
      }
      print(value);
    });

    // print(appointmentBooking.toMap());
  }

  getAllAppointments() async {
    await abController.getAppointmentBookings().then((value) {
      setState(() {
        appointmentData = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAppointments();
    nameController = TextEditingController();
    emailController = TextEditingController();
    departmentController = TextEditingController();
    locationController = TextEditingController();
    issueFacingController = TextEditingController();
    timeController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    departmentController.dispose();
    locationController.dispose();
    issueFacingController.dispose();
    timeController.dispose();
    super.dispose();
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
                              'Appointment Booking',
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
                          'Busy or stuck somewhere and not feeling\nwell...? Book an appointment for tomorrow...',
                          style: smallTextWhite,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    hintText: 'Full Name',
                                    onChanged: (p0) {
                                      setState(() {
                                        nameController.text = p0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Email',
                                onChanged: (p0) {
                                  setState(() {
                                    emailController.text = p0;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Department',
                                onChanged: (p0) {
                                  setState(() {
                                    departmentController.text = p0;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Location',
                                onChanged: (p0) {
                                  setState(() {
                                    locationController.text = p0;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/location.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Issue Facing',
                                onChanged: (p0) {
                                  setState(() {
                                    issueFacingController.text = p0;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.selectTime,
                                    arguments: appointmentData)
                                .then((value) {
                              setState(() {
                                timeController.text =
                                    formatDate(value as DateTime);
                                getVal = value;
                              });
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  readOnly: true,
                                  controller: timeController,
                                  hintText: 'Preferred Time',
                                  onChanged: (p0) {
                                    setState(() {
                                      timeController.text = p0;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, RouteNames.selectTime,
                                          arguments: appointmentData)
                                      .then((value) {
                                    // print(value.runtimeType);
                                    setState(() {
                                      timeController.text =
                                          formatDate(value as DateTime);
                                      getVal = value;
                                    });
                                  });
                                },
                                child: const IconBox(
                                  icon: 'assets/icons/clock.png',
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SmallButton(
                  text: 'Book Now',
                  onPressed: () {
                    bookAppointment();
                  },
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
