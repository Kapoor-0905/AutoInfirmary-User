import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/emergencyContactController.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';

class ManageContactTile extends StatefulWidget {
  final Map<String, dynamic> args;
  final String id;
  const ManageContactTile({
    super.key,
    required this.args,
    required this.id,
  });

  @override
  State<ManageContactTile> createState() => _ManageContactTileState();
}

class _ManageContactTileState extends State<ManageContactTile> {
  EmergencyContactController ecController = EmergencyContactController();
  Future deleteContact() async {
    await ecController.deleteContact(contactId: widget.id).then((value) {
      print(value);
      // successToast(message: 'Contact Deleted Successfully');
    });
  }

  deletePopUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(
              'Delete Contact',
              style: normalTextBold.copyWith(color: Colors.red),
            ),
            content: Text(
              'Are you sure you want to delete this contact?',
              style: smallText.copyWith(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: smallTextBold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteContact();
                  Navigator.pop(context);
                },
                child: Text(
                  "Delete",
                  style: smallTextBold.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: containerDecoration,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Image.asset('assets/icons/person.png',
                        color: primaryColor, scale: 10.5),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.args['name'],
                        style: smallTextBold,
                        textScaler: TextScaler.noScaling,
                      ),
                      Text(widget.args['phoneNum'],
                          style: smallText, textScaler: TextScaler.noScaling)
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // makePhoneCall(phoneNumber);
              Navigator.pushNamed(context, RouteNames.editContact,
                  arguments: widget.args);
            },
            child: const IconBox(icon: 'assets/icons/edit.png'),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              deletePopUp();
              // deleteContact();
            },
            child: const IconBox(icon: 'assets/icons/delete.png'),
          )
        ],
      ),
    );
  }
}
