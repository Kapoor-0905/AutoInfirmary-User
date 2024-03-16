import 'dart:collection';
import 'dart:ffi';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class SelectTime extends StatefulWidget {
  final List args;
  const SelectTime({super.key, required this.args});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  EventController controller = EventController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppointmentsAtTheTime();
  }

  setAppointmentsAtTheTime() {
    for (var arg in widget.args) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: DayView(
        dayTitleBuilder: (date) {
          final formattedDate = DateFormat.yMMMd().format(date);
          return Center(child: Text(formattedDate));
        },

        controller: controller,
        eventTileBuilder: (date, events, boundry, start, end) {
          // Return your widget to display as event tile.
          return Row(
            children: List.generate(
              events.length,
              (index) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: events.length == 1
                        ? Colors.green
                        : events.length > 3
                            ? Colors.red
                            : Colors.yellow,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  controller.getEventsOnDay(DateTime.now())[index].title,
                  style: normalText,
                ),
              ),
            ),
          );

          // Container(
          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //       color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
          //   child: Text(
          //     controller.getEventsOnDay(DateTime.now())[0].title,
          //     style: normalText,
          //   ),
          // );
        },
        // fullDayEventBuilder: (events, date) {
        //   // Return your widget to display full day event view.
        //   return Container(
        //     child: Text(
        //       controller.getEventsOnDay(DateTime.now())[0].title,
        //       style: normalText,
        //     ),
        //   );
        // },
        showVerticalLine: true, // To display live time line in day view.
        showLiveTimeLineInAllDays:
            true, // To display live time line in all pages in day view.R
        minDay: DateTime(1990),
        maxDay: DateTime(2050),
        initialDay: DateTime.now(),
        heightPerMinute: 1, // height occupied by 1 minute time span.
        eventArranger:
            MergeEventArranger(), // To define how simultaneous events will be arranged.
        onEventTap: (events, date) => print(events),
        onDateLongPress: (date) => print(date),
        startHour: 0, // To set the first hour displayed (ex: 05:00)

        // To Hide day header
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.add(
            CalendarEventData(
                title: 'task2',
                date: DateTime.utc(2024, 3, 15),
                startTime: DateTime.utc(2024, 3, 15, 15, 0, 0),
                endTime: DateTime.utc(2024, 3, 15, 16, 0, 0)),
          );
          print(controller.getEventsOnDay(DateTime.now()));
        },
      ),
    );
  }

  Widget _tileBuilder() => Container(
        color: Colors.blue,
        height: 50,
        child: Text('Hellp'),
      );
}

class Event {
  final String title;
  final Color color;

  Event(this.title, this.color);
}
