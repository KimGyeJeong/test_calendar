import 'package:go_router/go_router.dart';
import 'package:test_calendar/1_presentatation/login_page/login_page_view.dart'
    as login;
import 'package:test_calendar/1_presentatation/test/test_page_view.dart'
    as test;
import 'package:test_calendar/1_presentatation/calendar/calendar_view.dart'
    as calendar;

GoRouter router() {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const login.LoginPage(),
    ),
    GoRoute(
      path: '/testpage',
      builder: (context, state) => const test.TestPage(),
    ),
    GoRoute(
        path: '/calendar',
        builder: (context, state) => const calendar.CalendarMain(),
        routes: [
          GoRoute(
              path: '222',
              builder: (context, state) => const calendar.Calendar222()),
        ])
  ]);
}
