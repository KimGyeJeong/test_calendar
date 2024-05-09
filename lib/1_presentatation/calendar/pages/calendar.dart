// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_calendar/1_presentatation/calendar/calendar_view_model.dart';
import 'package:test_calendar/1_presentatation/calendar/provider/calendar_provider.dart';

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
  List<Event> eventsForDay = [];

  @override
  void initState() {
    super.initState();
    // ref.read(eventProvider.notifier).setEvents();

    //수정
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(eventProvider.notifier).setEvents();
      events = ref.watch(eventProvider).events!;
    });
    // getEvents();
  }

  @override
  void dispose() {
    // ref.read(eventProvider.notifier).clearEvents();
    super.dispose();
  }

  Future<void> getEvents() async {
    print('### tempcalled()');
    ref.read(eventProvider.notifier).setEvents();
    events = ref.watch(eventProvider).events!;

    Future.delayed(Duration(seconds: 1), () {
      print('### tempcalled() : ${events['202404']?.first.eventContent}');
    });

    print('@@@ temp : $events');
  }

  List<Event> getEventsForDay(String day) {
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
        // IconButton(
        //     onPressed: () {
        //       print('#### FLOATING ACTION BUTTON ####');
        //       temp();
        //       print('#### temp : $events');
        //       print('#### temp222 : ${ref.watch(eventProvider).events}');
        //     },
        //     icon: Icon(Icons.add)),
        SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SafeArea(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    // return Text('### ${eventsForDay[index].eventContent}');
                    return Center(
                      child: Row(
                        children: [
                          Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                      eventsForDay[index].eventUserNickname))),
                          // Text(eventsForDay[index].eventIndex.toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(eventsForDay[index].eventUser.toString()),
                          SizedBox(
                            width: 20,
                          ),
                          // Text(eventsForDay[index].eventTime.toString()),
                          Text(eventsForDay[index].eventContent),
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: eventsForDay.length),
            ),
          ),
        )
      ],
    );
  }

  // TableCalendar<dynamic> Calendar() {
  TableCalendar<Event> Calendar() {
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
          ref.read(calendarProvider.notifier).setCalendarTodate(selectedDay);

          print('#### onDaySelected : $selectedDay');
          eventsForDay =
              getEventsForDay(DateFormat('yyyyMMdd').format(selectedDay));
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

        eventsForDay.clear();
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
