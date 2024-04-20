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

  void setInputEventContent(String inputEventContent) {
    print(
        '#### calendar_provider.dart: setInputEventContent: $inputEventContent');
    state = state.copyWith(inputEventContent: inputEventContent);
  }
}

class CalendarState extends Equatable {
  final DateTime? selectedDay;
  final String? inputEventContent;

  CalendarState({
    this.selectedDay,
    this.inputEventContent,
  });

  CalendarState copyWith({DateTime? selectedDay, String? inputEventContent}) {
    return CalendarState(
        selectedDay: selectedDay ?? this.selectedDay,
        inputEventContent: inputEventContent ?? this.inputEventContent);
  }

  @override
  List<Object?> get props => [selectedDay, inputEventContent];
}
