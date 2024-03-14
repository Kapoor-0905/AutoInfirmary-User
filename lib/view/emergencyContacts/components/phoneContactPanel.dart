import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class PhoneContactPanel extends StatefulWidget {
  final List<Contact> contacts;
  const PhoneContactPanel({super.key, required this.contacts});

  @override
  State<PhoneContactPanel> createState() => _PhoneContactPanelState();
}

class _PhoneContactPanelState extends State<PhoneContactPanel> {
  String selectedName = "";
  String selectedPhone = "";
  String selectedEmail = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(widget.contacts.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedName = widget.contacts[index].displayName;
                  selectedPhone = widget.contacts[index].phones.isNotEmpty
                      ? widget.contacts[index].phones.first.number
                      : "None";
                  selectedEmail = widget.contacts[index].emails.isNotEmpty
                      ? widget.contacts[index].emails.first.address
                      : "None";
                });
                Navigator.pop(context, {
                  'name': selectedName,
                  'phone': selectedPhone,
                  'email': selectedEmail
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: primaryColor.withOpacity(0.2),
                        child: widget.contacts[index].photo == null
                            ? Image.asset('assets/icons/person.png',
                                color: primaryColor, scale: 10.5)
                            : Image.memory(widget.contacts[index].photo!)),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contacts[index].displayName,
                          style: smallText,
                        ),
                        Text(
                          widget.contacts[index].phones.isNotEmpty
                              ? widget.contacts[index].phones.first.number
                              : "None",
                          style: smallText.copyWith(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Contact(id=F57C8277-585D-4327-88A6-B5689FF69DFE, displayName=Anna Haro, thumbnail=null, photo=null, isStarred=false, name=Name(first=, last=, middle=, prefix=, suffix=, nickname=, firstPhonetic=, lastPhonetic=, middlePhonetic=), phones=[], emails=[], addresses=[], organizations=[], websites=[], socialMedias=[], events=[], notes=[], accounts=[], groups=[])