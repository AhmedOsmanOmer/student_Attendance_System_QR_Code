import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBlocBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBlocBloc() : super(AppBlocInitial()) {
    on<AppBlocEvent>((event, emit) {
    });
  }
}
