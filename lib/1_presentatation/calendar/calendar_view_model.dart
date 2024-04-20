// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_calendar/2_data/repos/event_repos.dart' as eventRepos;

final eventProvider =
    NotifierProvider<EventNotifier, EventState>(EventNotifier.new);

class EventNotifier extends Notifier<EventState> {
  @override
  EventState build() {
    return EventState();
  }

  void setEvents() async {
    print('### event_view_model.dart: setEvents:');
    //event 추가
    var result =
        await ref.read(eventRepos.eventRepositoryProvider).getEventMonth();
    // state = state.copyWith(events: <String, List<Event>>{});
    print('@@@ event_view_model.dart: setEvents: ${state.events}');
    state = state.copyWith(events: Map.of(result));
    // print('--------------------');
    // print(result.length);
    // print(result[0]);
    // print(result.runtimeType); // List<dynamic>
    // print(result[0].runtimeType); // _Map<String, dynamic>

    // print(result[0]["EVENT_CONTENTS"]); // go home now
    // result.forEach((element) {
    //   state = state.copyWith(events: <String, List<Event>>{
    //     element["MONTH"]: [
    //       Event(
    //         month: element["MONTH"],
    //         eventIndex: element["EVENT_INDEX"],
    //         eventUser: element["USER_ID_INDEX"],
    //         eventTime: DateTime.parse(element["EVENT_DATE"]),
    //         eventContent: element["EVENT_CONTENTS"],
    //       ),
    //     ],
    //   });
    // });

    // state = state.copyWith(events: result);
    // print('state.events: ${state.events}');
  }

  void clearEvents() {
    state = state.copyWith(events: {});
  }
}

//MAP
class EventState extends Equatable {
  //수정 24.04.14
  // final Map<DateTime, List<Event>> events = {};
  final Map<String, List<Event>>? events;

  // EventState({Map<DateTime, List<Event>>? events});
  EventState({this.events = const <String, List<Event>>{}});
  //수정 끝 24.04.14

  EventState copyWith({
    Map<String, List<Event>>? events,
  }) {
    return EventState(
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [events];
}

class Event {
  final String month;
  final int eventIndex;
  final int eventUser;
  DateTime? eventTime;
  final String eventContent;
  final String eventUserNickname;
  Event({
    required this.month,
    required this.eventIndex,
    required this.eventUser,
    this.eventTime = null,
    required this.eventContent,
    required this.eventUserNickname,
  });
}

// List<Event> getEventsForDay(DateTime day) {
//   return events[day] ?? [];
// }
