import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/emergencyBookingController.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';
import 'package:quickcare_user/models/emergencyBooking.dart';

class EmergencyBooking extends StatefulWidget {
  final Map<String, dynamic> userData;
  const EmergencyBooking({super.key, required this.userData});

  @override
  State<EmergencyBooking> createState() => _EmergencyBookingState();
}

class _EmergencyBookingState extends State<EmergencyBooking> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController departmentController;
  late TextEditingController locationController;
  late TextEditingController issueFacingController;
  late TextEditingController approxTimeOfArrivalController;
  late TextEditingController needAmbulanceController;
  bool needAnAmbulance = false;
  TimeOfDay? timeVal = TimeOfDay.fromDateTime(DateTime.now());
  EmergencyBookingController emergencyBookingController =
      EmergencyBookingController();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: '${widget.userData['firstName']} ${widget.userData['lastName']}');
    emailController = TextEditingController(text: widget.userData['email']);
    departmentController = TextEditingController();
    locationController = TextEditingController();
    issueFacingController = TextEditingController();
    approxTimeOfArrivalController = TextEditingController();
    needAmbulanceController = TextEditingController();
    print(widget.userData['firstName']);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    departmentController.dispose();
    locationController.dispose();
    issueFacingController.dispose();
    approxTimeOfArrivalController.dispose();
    super.dispose();
  }

  bookEmergencyAppointment() async {
    String? id = await SF.getUserId();

    EmergencyBookingModel emergencyBooking = EmergencyBookingModel(
      fullName: nameController.text,
      email: emailController.text,
      department: departmentController.text,
      location: locationController.text,
      issueFacing: issueFacingController.text,
      approxTimeOfArrival: approxTimeOfArrivalController.text,
      userId: id!,
      needAmbulance: needAnAmbulance,
      bookingDate: DateTime.now().toString(),
    );
    validate() == false
        ? errorToast(message: 'Kindly fill all the fields')
        : await emergencyBookingController
            .createEmergencyBooking(emergencyBooking: emergencyBooking)
            .then((value) {
            successToast(message: 'Emergency Booked successfully');
            setState(() {
              nameController.clear();
              emailController.clear();
              locationController.clear();
              departmentController.clear();
              issueFacingController.clear();
              approxTimeOfArrivalController.clear();
            });
          });
    // print(emergencyBooking.toMap());
  }

  validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        departmentController.text.isEmpty ||
        locationController.text.isEmpty ||
        issueFacingController.text.isEmpty ||
        approxTimeOfArrivalController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
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
                              'Emergency Booking',
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
                          'In an emergency...? Book right now and get\nhigh priority at infirmary ',
                          style: smallTextWhite,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Full Name',
                                onChanged: (p0) {},
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
                                controller: emailController,
                                keyboardType: TextInputType.phone,
                                hintText: 'Email',
                                onChanged: (p0) {},
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
                                controller: departmentController,
                                hintText: 'Department',
                                onChanged: (p0) {},
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
                                controller: locationController,
                                hintText: 'Location',
                                onChanged: (p0) {},
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
                                controller: issueFacingController,
                                hintText: 'Issue Facing',
                                onChanged: (p0) {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            timeVal = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext? context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context!)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              },
                            ).then((value) {
                              setState(() {
                                if (value != null) {
                                  approxTimeOfArrivalController.text =
                                      value.format(context);
                                }
                              });
                              return value;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: approxTimeOfArrivalController,
                                  readOnly: true,
                                  hintText: 'Approx. time of arrival',
                                  onChanged: (p0) {},
                                ),
                              ),
                              const SizedBox(width: 15),
                              const IconBox(
                                icon: 'assets/icons/clock.png',
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                readOnly: true,
                                controller: needAmbulanceController,
                                hintText: 'Need an ambulance?',
                                onChanged: (p0) {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            Switch(
                                inactiveThumbColor:
                                    Colors.black.withOpacity(0.3),
                                inactiveTrackColor: accentColor,
                                activeColor: accentColor,
                                trackColor: MaterialStateColor.resolveWith(
                                    (states) => primaryColor.withOpacity(0.3)),
                                thumbColor: MaterialStateColor.resolveWith(
                                    (states) => primaryColor),
                                value: needAnAmbulance,
                                onChanged: (p0) {
                                  setState(() {
                                    needAnAmbulance = p0;
                                    p0
                                        ? needAmbulanceController.text == 'Yes'
                                        : 'No';
                                  });
                                })
                          ],
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
                    bookEmergencyAppointment();
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
