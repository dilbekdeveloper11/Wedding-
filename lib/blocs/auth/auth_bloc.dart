import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/providers/token_provider.dart';
import 'package:wedding_app/services/auth_servie.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService authService = AuthService();
  TokenDataProvider tokenDataProvider = TokenDataProvider();
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authService.registerUser(
          username: event.username,
          phone: event.phone,
          cite: event.cite,
          weddingDate: event.weddingDate,
        );

        final String token = await authService.makeToken(phone: event.phone);

        tokenDataProvider.box.write('tokenID',token);

        print(token);

        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError());
      }
    });
  }
}
