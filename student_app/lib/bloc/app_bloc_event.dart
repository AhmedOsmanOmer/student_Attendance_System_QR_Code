part of 'app_bloc_bloc.dart';

@immutable
sealed class AppBlocEvent {}

class LoadUsers extends AppBlocEvent {}

class Login extends AppBlocEvent {
  final String id;
  Login({required this.id});
}



class ScanQrCode extends AppBlocEvent {

}
