import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';
import '../../services/services.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(AuthenticationInitial()) {
          on<AppLoaded>(_onAppLoaded);
          on<UserLoggedIn>(_onUserLoggedIn);
          on<UserLoggedOut>(_onUserLoggedOut);
        }


  _onAppLoaded(
    AppLoaded event,
    Emitter<AuthenticationState> emit,
  ) async {
      emit(AuthenticationLoading());
      try {
        await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
        final currentUser = await _authenticationService.getCurrentUser();

        if (currentUser != null) {
          emit(AuthenticationAuthenticated(user: currentUser));
        } else {
          emit(AuthenticationNotAuthenticated());
        }
      } on Exception catch (e) {
        emit(AuthenticationFailure(message: 'An unknown error occurred: ${e.toString()}'));
      }
  }

  _onUserLoggedIn(
    UserLoggedIn event,
    Emitter<AuthenticationState> emit,
   ) async {
    emit(AuthenticationAuthenticated(user: event.user));
  }

  _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationService.signOut();
    emit(AuthenticationNotAuthenticated());
  }

}
