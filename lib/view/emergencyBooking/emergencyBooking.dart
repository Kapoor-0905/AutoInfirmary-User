import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class EmergencyBooking extends StatefulWidget {
  const EmergencyBooking({super.key});

  @override
  State<EmergencyBooking> createState() => _EmergencyBookingState();
}

class _EmergencyBookingState extends State<EmergencyBooking> {
  bool needAnAmbulance = false;
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
                                keyboardType: TextInputType.phone,
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
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
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
