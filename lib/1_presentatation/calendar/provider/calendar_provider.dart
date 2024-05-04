// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/2_data/repos/event_repos.dart';

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

  void saveEvents(int userIndex, DateTime eventTime, String eventContent) {
    print(
        '#### calendar_provider.dart: saveEvents: ${state.inputEventContent}');
    //TODO : save event
    ref
        .read(eventRepositoryProvider)
        .saveEvent(userIndex, eventTime, eventContent);

    print(
        '#### calendar_provider.dart: saveEvents: ${state.inputEventContent}');
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
