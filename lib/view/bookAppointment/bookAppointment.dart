import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
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
                                    onChanged: (p0) {},
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
                                hintText: 'Mobile Number',
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
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Preferred Time',
                                onChanged: (p0) {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/clock.png',
                            )
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
                  onPressed: () {},
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
