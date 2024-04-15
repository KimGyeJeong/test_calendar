import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/2_data/repos/auth_repos.dart' as auth;

final loginProvider =
    NotifierProvider<LoginNotifier, LoginState>(LoginNotifier.new);

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState();
  }

  void setId(String id) {
    state = state.copyWith(id: id);
  }

  void setPw(String pw) {
    state = state.copyWith(pw: pw);
  }

  void setLoginFailCount(int loginFailCount) {
    state = state.copyWith(loginFailCount: loginFailCount);
  }

  void logintest() async {
    await ref.read(auth.authRepositoryProvider).testLogin(state.id, state.pw);
    print(
        '#### login_page_view_model.dart: logintest: ${state.id}, ${state.pw}, ${state.loginFailCount}');
  }
}

class LoginState extends Equatable {
  final String id;
  final String pw;
  final int loginFailCount;

  LoginState({
    this.id = '',
    this.pw = '',
    this.loginFailCount = 0,
  });
  @override
  List<Object?> get props => [id, pw, loginFailCount];

  LoginState copyWith({
    String? id,
    String? pw,
    int? loginFailCount,
  }) {
    return LoginState(
      id: id ?? this.id,
      pw: pw ?? this.pw,
      loginFailCount: loginFailCount ?? this.loginFailCount,
    );
  }
}
