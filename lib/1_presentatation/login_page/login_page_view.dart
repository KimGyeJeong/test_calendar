// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_calendar/1_presentatation/login_page/login_page_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/1_presentatation/login_page/login_page_view_model.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            LoginMainPage(),
            TestPage(),
          ],
        ),
      ),
    );
  }
}

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Login'),
          LoginArea(),
        ],
      ),
    );
  }
}

class LoginArea extends StatelessWidget {
  const LoginArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IdTextField(),
        PwTextField(),
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/calendar');
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}

class PwTextField extends ConsumerWidget {
  const PwTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'PW',
        hintText: 'password',
      ),
      onChanged: ref.read(loginProvider.notifier).setPw,
    );
  }
}

class IdTextField extends ConsumerWidget {
  const IdTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(labelText: 'ID', hintText: 'id@email.com'),
      onChanged: ref.read(loginProvider.notifier).setId,
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          GoRouter.of(context).go('/testpage');
        },
        child: const Text('Test Page'),
      ),
    );
  }
}
