// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthResponse _$MonthResponseFromJson(Map<String, dynamic> json) =>
    MonthResponse(
      result: (json['result'] as List<dynamic>)
          .map((e) => Events.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MonthResponseToJson(MonthResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

Events _$EventsFromJson(Map<String, dynamic> json) => Events(
      month: json['MONTH'] as String,
      eventIndex: json['EVENT_INDEX'] as int,
      eventUserIndex: json['USER_ID_INDEX'] as int,
      eventTime: DateTime.parse(json['EVENT_DATE'] as String),
      eventContent: json['EVENT_CONTENTS'] as String,
    );

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'MONTH': instance.month,
      'EVENT_INDEX': instance.eventIndex,
      'USER_ID_INDEX': instance.eventUserIndex,
      'EVENT_DATE': instance.eventTime.toIso8601String(),
      'EVENT_CONTENTS': instance.eventContent,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _Api implements Api {
  _Api(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.0.2.2:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> connectTest() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> getTest() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/login',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> postLogin(UserInfo userInfo) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userInfo.toJson());
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/login',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data!;
    return value;
  }

  @override
  Future<MonthResponse> getEventMonth() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MonthResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/getEvents',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MonthResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
