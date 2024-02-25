import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(const DrawerInitial()) {
    on<OpenDrawer>((event, emit) {
      emit(const DrawerInitial());
    });

    on<CloseDrawer>((event, emit) {
      emit(const DrawerInitial());
    });
  }
}
