import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: heading,
              ),
              Divider(
                color: primaryColor,
                thickness: 0.5,
                endIndent: size.width * 0.3,
                indent: size.width * 0.3,
              ),
              const Text(
                'Details',
                style: normalText,
              ),
              SizedBox(
                  height: size.height * 0.3,
                  child: Image.asset(
                    'assets/images/login.png',
                    scale: 1.7,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Full Name',
                      onChanged: (p0) {},
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextField(
                      hintText: 'Phone Number',
                      onChanged: (p0) {},
                      keyboardType: TextInputType.phone,
                    ),
                    CustomTextField(
                      hintText: 'Unique Organization Code',
                      onChanged: (p0) {},
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    CustomTextField(
                      hintText: 'Address',
                      onChanged: (p0) {},
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 20),
                    SmallButton(text: 'Create Account', onPressed: () {}),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
