// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_calendar/1_presentatation/login_page/login_page_view_model.dart';
import 'package:test_calendar/1_presentatation/calendar/calendar_view_model.dart';
// import 'package:test_calendar/1_presentatation/test/test_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/2_data/repos/auth_repos.dart';
import 'package:test_calendar/2_data/repos/event_repos.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            IsConnect(),
            Text('Test Page'),
            LoginTest(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () {
          GoRouter.of(context).go('/');
        },
      ),
    );
  }
}

class IsConnect extends ConsumerWidget {
  const IsConnect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              print('${ref.read(authRepositoryProvider).testConnect()}');
            },
            child: Text('Connect')),
        Text('111 : ${ref.watch(authRepositoryProvider).testConnect()}'),
        SizedBox(height: 20),
      ],
    );
  }
}

class LoginTest extends ConsumerWidget {
  const LoginTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                ref.read(loginProvider.notifier).setId('temp@temp.com');
                ref.read(loginProvider.notifier).setPw('1234');
                ref.read(loginProvider.notifier).logintest();
              },
              child: Text('Login Auto')),
          TextField(
            decoration: InputDecoration(labelText: 'ID', hintText: '_id'),
            onChanged: (value) => ref.read(loginProvider.notifier).setId(value),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'PW'),
            onChanged: (value) => ref.read(loginProvider.notifier).setPw(value),
          ),
          ElevatedButton(
              onPressed: () {
                print(
                    '###### ${ref.watch(loginProvider).id} , ${ref.watch(loginProvider).pw}, ${ref.watch(loginProvider).loginFailCount}');
              },
              child: Text('Login')),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                print('CLICK');
                // print(
                //     '#####CALENDAR CLICK ${ref.read(eventProvider.notifier).setEvents}');
                ref.read(eventProvider.notifier).setEvents();
              },
              child: Text('Calendar')),
          Text('calendar : ${ref.watch(eventProvider).events}'),
        ],
      ),
    );
  }
}
