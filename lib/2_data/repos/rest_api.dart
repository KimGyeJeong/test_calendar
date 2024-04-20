import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:3000')
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET('/')
  Future<String> connectTest();

  @GET('/login')
  Future<String> getTest();

  @POST('/login')
  Future<String> postLogin(@Body() UserInfo userInfo);

  @GET('/getEvents')
  Future<MonthResponse> getEventMonth();

//TODO saveEvent
  @POST('/saveEvent')
  Future<dynamic> saveEvent(@Body() Events event);
}

@JsonSerializable()
class MonthResponse {
  final List<Events> result;

  MonthResponse({
    required this.result,
  });

  factory MonthResponse.fromJson(Map<String, dynamic> json) =>
      _$MonthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MonthResponseToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String email;
  final String password;
  UserInfo({
    required this.email,
    required this.password,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Events {
  @JsonKey(name: 'MONTH')
  final String month;
  @JsonKey(name: 'EVENT_INDEX')
  final int eventIndex;
  @JsonKey(name: 'USER_ID_INDEX')
  final int eventUserIndex;
  @JsonKey(name: 'EVENT_DATE')
  final DateTime eventTime;
  @JsonKey(name: 'EVENT_CONTENTS')
  final String eventContent;
  @JsonKey(name: 'USER_NICKNAME')
  final String eventUserNickname;

  Events({
    required this.month,
    required this.eventIndex,
    required this.eventUserIndex,
    required this.eventTime,
    required this.eventContent,
    required this.eventUserNickname,
  });

  factory Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);
  Map<String, dynamic> toJson() => _$EventsToJson(this);
}
