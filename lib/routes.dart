import 'package:flutter/material.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/view/bookAppointment/bookAppointment.dart';
import 'package:quickcare_user/view/emergencyBooking/emergencyBooking.dart';
import 'package:quickcare_user/view/emergencyContacts/emergencyContacts.dart';
import 'package:quickcare_user/view/emergencyContacts/views/addContact.dart';
import 'package:quickcare_user/view/home/home.dart';
import 'package:quickcare_user/view/login/login.dart';
import 'package:quickcare_user/view/onboarding/onboardingOne.dart';
import 'package:quickcare_user/view/onboarding/onboardingThree.dart';
import 'package:quickcare_user/view/onboarding/onboardingTwo.dart';
import 'package:quickcare_user/view/profile/profile.dart';
import 'package:quickcare_user/view/register/register.dart';
import 'package:quickcare_user/view/register/views/details.dart';
import 'package:quickcare_user/view/splash/splashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  RouteNames.splash: (context) => const SplashScreen(),
  RouteNames.onboardingone: (context) => const OnboardingOne(),
  RouteNames.onboardingtwo: (context) => const OnboardingTwo(),
  RouteNames.onboardingthree: (context) => const OnboardingThree(),
  RouteNames.login: (context) => const Login(),
  RouteNames.register: (context) => const Register(),
  RouteNames.details: (context) => const Details(),
  RouteNames.home: (context) => const Home(),
  RouteNames.bookAppointment: (context) => const BookAppointment(),
  RouteNames.emergencyBooking: (context) => const EmergencyBooking(),
  RouteNames.emergencyContacts: (context) => const EmergencyContacts(),
  RouteNames.addContact: (context) => const AddContact(),
  RouteNames.profile: (context) => const Profile(),
};