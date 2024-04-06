import 'package:flutter/material.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/view/bookAppointment/bookAppointment.dart';
import 'package:quickcare_user/view/bookAppointment/views/selectTime.dart';
import 'package:quickcare_user/view/emergencyBooking/emergencyBooking.dart';
import 'package:quickcare_user/view/emergencyContacts/emergencyContacts.dart';
import 'package:quickcare_user/view/emergencyContacts/views/addContact.dart';
import 'package:quickcare_user/view/emergencyContacts/views/contactPage.dart';
import 'package:quickcare_user/view/home/home.dart';
import 'package:quickcare_user/view/login/login.dart';
import 'package:quickcare_user/view/onboarding/onboardingOne.dart';
import 'package:quickcare_user/view/onboarding/onboardingThree.dart';
import 'package:quickcare_user/view/onboarding/onboardingTwo.dart';
import 'package:quickcare_user/view/profile/profile.dart';
import 'package:quickcare_user/view/register/register.dart';
import 'package:quickcare_user/view/register/views/details.dart';
import 'package:quickcare_user/view/settings/settings.dart';
import 'package:quickcare_user/view/splash/splashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  RouteNames.splash: (context) => const SplashScreen(),
  RouteNames.onboardingone: (context) => const OnboardingOne(),
  RouteNames.onboardingtwo: (context) => const OnboardingTwo(),
  RouteNames.onboardingthree: (context) => const OnboardingThree(),
  RouteNames.login: (context) => const Login(),
  RouteNames.register: (context) => const Register(),
  RouteNames.details: (context) => Details(
        args: ModalRoute.of(context)!.settings.arguments as Map<String, String>,
      ),
  RouteNames.home: (context) => const Home(),
  RouteNames.bookAppointment: (context) => BookAppointment(
        userData:
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
      ),
  RouteNames.emergencyBooking: (context) => EmergencyBooking(
        userData:
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
      ),
  RouteNames.emergencyContacts: (context) => const EmergencyContacts(),
  RouteNames.addContact: (context) => const AddContact(),
  RouteNames.contactPage: (context) => ContactPage(
        args:
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
      ),
  RouteNames.selectTime: (context) => SelectTime(
        args: ModalRoute.of(context)!.settings.arguments as List,
      ),
  RouteNames.profile: (context) => const Profile(),
  RouteNames.settings: (context) => const Settings(),
};
