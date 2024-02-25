import 'package:belajar_bloc/note_app/data/datasources/task_remote_datasource.dart';
import 'package:belajar_bloc/note_app/data/models/task_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final TaskRemoteDatasource taskRemoteDatasource;
  GetTaskBloc(
    this.taskRemoteDatasource,
  ) : super(GetTaskInitial()) {
    on<DoGetAllTaskEvent>((event, emit) async {
      emit(GetTaskLoading());

      try {
        final model = await taskRemoteDatasource.getTasks();
        emit(GetTaskSuccess(model.data));
      } catch (e) {
        emit(GetTaskFailure(e.toString()));
      }
    });
  }
}
