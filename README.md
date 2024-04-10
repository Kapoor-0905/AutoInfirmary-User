# QuickCare (User)

### Folder Structure (Frontend)

> Architecture Followed : **MVC (Model-View-Controller)**

```bash
.
├── controllers
│   ├── appointmentBookingController.dart
│   ├── authController.dart
│   ├── emergencyBookingController.dart
│   ├── emergencyContactController.dart
│   ├── sharedPreferenceController.dart
│   └── userController.dart
├── demo.json
├── main.dart
├── models
│   ├── appointmentBooking.dart
│   ├── emergencyBooking.dart
│   ├── emergencyContact.dart
│   └── user.dart
├── routeNames.dart
├── routes.dart
├── utils
│   ├── animations.dart
│   ├── colors.dart
│   ├── functions.dart
│   ├── shimmers.dart
│   ├── styles.dart
│   ├── widgets
│   │   ├── bigButton.dart
│   │   ├── customTextField.dart
│   │   ├── iconBox.dart
│   │   └── smallButton.dart
│   └── widgets.dart
└── view
    ├── bookAppointment
    │   ├── bookAppointment.dart
    │   └── views
    │       └── selectTime.dart
    ├── emergencyBooking
    │   └── emergencyBooking.dart
    ├── emergencyContacts
    │   ├── components
    │   │   ├── contactTile.dart
    │   │   └── phoneContactPanel.dart
    │   ├── emergencyContacts.dart
    │   └── views
    │       ├── addContact.dart
    │       └── contactPage.dart
    ├── home
    │   ├── components
    │   │   └── menuTile.dart
    │   └── home.dart
    ├── login
    │   └── login.dart
    ├── onboarding
    │   ├── onboardingOne.dart
    │   ├── onboardingThree.dart
    │   └── onboardingTwo.dart
    ├── profile
    │   └── profile.dart
    ├── register
    │   ├── register.dart
    │   └── views
    │       └── details.dart
    ├── settings
    │   ├── components
    │   │   └── settingTile.dart
    │   └── settings.dart
    └── splash
        └── splashScreen.dart
```

### Folder Structure (Backend)

> Architecture Followed : **NodeJS**

```bash
prisma
└── schema.prisma
src
├── config
│   └── index.ts
├── controllers
│   ├── appointmentBooking.ts
│   ├── authentication.ts
│   ├── emergencyBooking.ts
│   ├── emergencyContacts.ts
│   └── users.ts
├── helpers
│   └── index.ts
├── index.ts
├── middleware
│   └── index.ts
├── routers
│   ├── api.ts
│   ├── appointmentBooking.ts
│   ├── authentication.ts
│   ├── emergencyBooking.ts
│   ├── emergencyContact.ts
│   ├── index.ts
│   └── users.ts
├── utils
│   ├── db.ts
│   └── logger.ts
└── index.ts

```
