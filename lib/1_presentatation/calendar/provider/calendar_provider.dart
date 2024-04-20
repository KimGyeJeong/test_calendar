// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarProvider =
    NotifierProvider<CalendarNotifier, CalendarState>(CalendarNotifier.new);

class CalendarNotifier extends Notifier<CalendarState> {
  @override
  CalendarState build() {
    return CalendarState();
  }

  void setCalendarTodate(DateTime selectedDay) {
    print('#### calendar_provider.dart: setCalendarTodate: $selectedDay');
    state = state.copyWith(selectedDay: selectedDay);
  }
}

class CalendarState extends Equatable {
  final DateTime? selectedDay;

  CalendarState({this.selectedDay});

  CalendarState copyWith({DateTime? selectedDay}) {
    return CalendarState(selectedDay: selectedDay ?? this.selectedDay);
  }

  @override
  List<Object?> get props => [selectedDay];
}
