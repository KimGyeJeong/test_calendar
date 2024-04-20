// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/1_presentatation/calendar/pages/calendar.dart';
import 'package:test_calendar/1_presentatation/calendar/provider/calendar_provider.dart';

class CalendarMain extends StatelessWidget {
  const CalendarMain({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: SafeArea(child: Text('1111')));
    return CalendarStart();
  }
}

class CalendarStart extends StatefulWidget {
  const CalendarStart({super.key});

  @override
  State<CalendarStart> createState() => _CalendarStartState();
}

class _CalendarStartState extends State<CalendarStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CALENDAR'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(height: 20.0),
              // Text('asdasd'),
              SizedBox(height: 20.0),
              TableBasics(),
              SizedBox(height: 20.0),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('#### FLOATING ACTION BUTTON ####');
            showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                      // height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SetEvent(),
                      ),
                    ));
          },
          child: Icon(Icons.add),
        ));
  }
}

class SetEvent extends ConsumerWidget {
  const SetEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(ref.watch(calendarProvider).selectedDay.toString()),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(hintText: 'Event Content'),
        ),
      ],
    );
  }
}
