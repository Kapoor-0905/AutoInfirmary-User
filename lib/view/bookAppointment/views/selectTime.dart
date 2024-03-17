import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/functions.dart';
import 'package:quickcare_user/utils/styles.dart';

class SelectTime extends StatefulWidget {
  final List args;
  const SelectTime({super.key, required this.args});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  bool added = false;
  List data = [];
  EventController controller = EventController();
  DateTime now = DateTime.now();
  TimeOfDay? timeVal = TimeOfDay.fromDateTime(DateTime.now());
  DateTime returnVal = DateTime.now();
  DateTime current = DateTime.now();

  // Set the time to midnight (12:00 AM)
  @override
  void initState() {
    super.initState();
    setAppointmentsAtTheTime();
  }

  setAppointmentsAtTheTime() {
    setState(() {
      data = widget.args;
    });
    // print(widget.args);
    for (var arg in data) {
      controller.add(
        CalendarEventData(
          title: arg['fullName'].toString().split(" ")[0],
          date: DateTime.parse(arg['bookingDate']),
          startTime: DateTime.parse(arg['bookingDate']),
          endTime:
              DateTime.parse(arg['bookingDate']).add(const Duration(hours: 1)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, size.height * 0.06, 20, 20),
          decoration: topBarDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Booking Time',
                    style: heading.copyWith(color: Colors.white, fontSize: 28),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, returnVal),
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
            ],
          ),
        ),
      ),
      body: DayView(
        dayTitleBuilder: (date) {
          final formattedDate = DateFormat.yMMMd().format(date);
          return Center(child: Text(formattedDate));
        },
        controller: controller,
        onDateTap: (date) {},
        eventTileBuilder: (date, events, boundry, start, end) {
          print(controller.allEvents.length);
          // Return your widget to display as event tile.
          return Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                color: 5 - events.length == 5
                    ? Colors.green
                    : 5 - events.length == 4
                        ? Colors.yellow
                        : 5 - events.length == 3
                            ? Colors.orange[400]
                            : 5 - events.length <= 2
                                ? Colors.red
                                : Colors.green),
            child: Text('${5 - events.length} slots available for ${getTime(start)}'),
          );
        },
        showVerticalLine: true,
        showLiveTimeLineInAllDays: true,
        minDay: DateTime(now.year, now.month, now.day),
        maxDay: DateTime(
          now.year,
          now.month,
          now.day,
          23, // Hour
          0, // Minute
          0, // Second
          0, // Millisecond
        ),
        initialDay: DateTime.now(),
        heightPerMinute: 1,
        eventArranger: const MergeEventArranger(),
        onEventTap: (events, date) {
          controller.remove(events.last);
        },
        startHour: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: added
            ? const Icon(
                Icons.close,
                color: Colors.white,
              )
            : const Icon(
                Icons.add,
                color: Colors.white,
              ),
        onPressed: () async {
          added
              ? Navigator.pop(context, returnVal)
              : {
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
                  ).then(
                    (value) {
                      setState(() {
                        added = true;
                        returnVal =
                            convertStringToDateTime(value!.format(context));
                      });
                      print(convertStringToDateTime(value!.format(context)));
                      controller.add(
                        CalendarEventData(
                          title: 'You',
                          date: convertStringToDateTime(value.format(context)),
                          startTime:
                              convertStringToDateTime(value.format(context)),
                          endTime:
                              convertStringToDateTime(value.format(context))
                                  .add(
                            const Duration(hours: 1),
                          ),
                        ),
                      );
                      print(controller.getEventsOnDay(DateTime.now()));
                      // Navigator.pop(context, returnVal);
                      return value;
                    },
                  )
                };
        },
      ),
    );
  }
}
