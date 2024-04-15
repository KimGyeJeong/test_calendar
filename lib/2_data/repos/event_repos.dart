import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/1_presentatation/calendar/calendar_view_model.dart';
import 'package:test_calendar/2_data/repos/rest_api.dart';

final eventRepositoryProvider = Provider<EventRepos>((ref) => EventRepos());

final dio = Dio();

class EventRepos {
  Future<Map<String, List<Event>>> getEventMonth() async {
    var result = await Api(dio).getEventMonth();
    // print("####event_repos.dart: getEventMonth: $resultJson");
    // print("####event_repos.dart: getEventMonth: ${resultJson.runtimeType}");

    // Map<String, dynamic> jsonResult = result

    Map<String, List<Event>> events = {};
    print('@@@ $result');
    for (var event in result.result) {
      events.putIfAbsent(event.month, () => []);
      events[event.month]!.add(
        Event(
          month: event.month,
          eventIndex: event.eventIndex,
          eventUser: event.eventUserIndex,
          eventTime: event.eventTime,
          eventContent: event.eventContent,
        ),
      );
    }
    print('@@@@@@@@@@@@');
    print(events);
    return events;
  }
}
