// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_calendar/1_presentatation/calendar/calendar_view_model.dart'
    as calendar_model;

class TableBasics extends StatefulWidget {
  const TableBasics({super.key});

  @override
  State<TableBasics> createState() => _TableBasicsState();
}

class _TableBasicsState extends State<TableBasics> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2024, 4, 3): [
      Event(
        eventIndex: 1,
        eventUser: 1,
        eventTime: DateTime.utc(2024, 4, 3),
        eventContent: 'Event 1',
      ),
      Event(
        eventIndex: 2,
        eventUser: 2,
        eventTime: DateTime.utc(2024, 4, 3),
        eventContent: 'Event 2',
      ),
    ],
    DateTime.utc(2024, 4, 6): [
      Event(
        eventIndex: 3,
        eventUser: 3,
        eventContent: 'Event 3',
      ),
      Event(
        eventIndex: 4,
        eventUser: 4,
        eventTime: DateTime.utc(2024, 4, 6),
        eventContent: 'Event 4',
      ),
      Event(
        eventIndex: 5,
        eventUser: 5,
        eventTime: DateTime.utc(2024, 4, 6),
        eventContent: 'Event 5',
      ),
    ],
  };

  List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
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
        return getEventsForDay(day);
      },
    );
  }
}

class Event {
  final int eventIndex;
  final int eventUser;
  DateTime? eventTime;
  final String eventContent;
  Event({
    required this.eventIndex,
    required this.eventUser,
    this.eventTime = null,
    required this.eventContent,
  });
}
