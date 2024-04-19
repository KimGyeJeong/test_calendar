// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_calendar/1_presentatation/calendar/calendar_view_model.dart';

class TableBasics extends ConsumerStatefulWidget {
  const TableBasics({super.key});

  @override
  ConsumerState<TableBasics> createState() => _TableBasicsState();
}

class _TableBasicsState extends ConsumerState<TableBasics> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<String, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    // ref.read(eventProvider.notifier).setEvents();
    temp();
  }

  @override
  void dispose() {
    // ref.read(eventProvider.notifier).clearEvents();
    super.dispose();
  }

  Future<void> temp() async {
    print('### tempcalled()');
    ref.read(eventProvider.notifier).setEvents();
    events = ref.watch(eventProvider).events!;

    Future.delayed(Duration(seconds: 1), () {
      print('### tempcalled() : ${events['202404']?.first.eventContent}');
    });

    print('@@@ temp : $events');
  }

  List<Event> getEventsForDay(String day) {
    String days = day.substring(0, 6);

    print('### getEventsForDay : $day');
    // print('### getEventsForDay. : ${events[days]}');
    print('### getEventsForDay. : ${events[day]}');
    // ref.read(eventProvider.notifier).setEvents();
    events = ref.watch(eventProvider).events!;
    // print('### getEventsForDay.... : ${events[days]}');
    // events.forEach((key, value) {
    //   print('### key : $key, value : $value');
    //   print('### events[$days] : ${events[days]}');
    //   value.forEach((element) {
    //     print('### element eventIndex : ${element.eventIndex}');
    //     print('### element eventTime : ${element.eventTime}');
    //     print('### element eventUser : ${element.eventUser}');
    //     print('### element eventContent : ${element.eventContent}');
    //   });
    // });

    // return events[days] ?? [];
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Calendar(),
        SizedBox(
          height: 20,
        ),
        Text('data : ${events['202404']?.first.eventContent ?? 'no data'}'),
        SizedBox(
          height: 20,
        ),
        IconButton(
            onPressed: () {
              print('#### FLOATING ACTION BUTTON ####');
              temp();
              print('#### temp : $events');
              print('#### temp222 : ${ref.watch(eventProvider).events}');
            },
            icon: Icon(Icons.add)),
      ],
    );
  }

  TableCalendar<dynamic> Calendar() {
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
        // // ADD 2024.04.20
        // 달력의 날짜 아래 이벤트 표시들
        // markerBuilder: ((context, day, events) {
        //   if (events.isNotEmpty) {
        //     List eventevents = events;
        //     return Text('### ${eventevents.length}');
        //   }
        // }),
        // Add 2024.04.20 end
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday) {
            final text = DateFormat.E().format(day);

            return Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        },
      ),
      // firstDay: DateTime(
      //     DateTime.now().year, DateTime.now().month - 3, DateTime.now().day),
      firstDay: DateTime.utc(2000, 1, 1),
      // lastDay: DateTime(
      //     DateTime.now().year, DateTime.now().month + 3, DateTime.now().day),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      calendarStyle: CalendarStyle(
        // Use `CalendarStyle` to customize the UI
        outsideDaysVisible: false,
        // weekendTextStyle: TextStyle(color: Colors.red),
      ),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        print("@@@@ onPageChanged focusedDay : $focusedDay");
        ref.read(eventProvider.notifier).setEvents();
        _focusedDay = focusedDay;
      },
      // locale: 'ko_KR',
      locale: 'en_US',
      daysOfWeekHeight: 30,
      eventLoader: (day) {
        // if (day.day % 4 == 0) {
        //   return [day];
        // } else {
        //   return [];
        // }
        // return calendar_model.getEventsForDay(day);
        // return getEventsForDay(day);
        // return [];
        // ref.read(eventProvider.notifier).setEvents();
        // events = ref.watch(eventProvider).events!;

        // print('#### eventLoader : ${events['202404']}');
        // temp();
        // print('### eventloader ${events['202404']!.first.eventContent}');
        // return [events['202404']!.first.eventTime ?? []];

        // getEventsForDay(day);

        // return getEventsForDay(DateFormat('yyyyMMdd').format(day))
        //     .map((e) => e.eventTime)
        //     .toList();

        return getEventsForDay(DateFormat('yyyyMMdd').format(day));
      },
    );
  }
}

// class Event {
//   final int eventIndex;
//   final int eventUser;
//   DateTime? eventTime;
//   final String eventContent;
//   Event({
//     required this.eventIndex,
//     required this.eventUser,
//     this.eventTime = null,
//     required this.eventContent,
//   });
// }
