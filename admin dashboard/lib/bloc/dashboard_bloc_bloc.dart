import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'dashboard_bloc_event.dart';
part 'dashboard_bloc_state.dart';

class DashboardBlocBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  DashboardBlocBloc() : super(DashboardBlocInitial()) {
    on<DashboardBlocEvent>((event, emit) {});
    on<LoadTeacherDataEvent>(_loadTeacherData);
  }
  Future<void> _loadTeacherData(
      LoadTeacherDataEvent event, Emitter<DashboardBlocState> emit) async {
    emit(LoadingState());
    try {
       
      emit(TeacherDataLoadedState());
    } catch (e) {}
  }
}
