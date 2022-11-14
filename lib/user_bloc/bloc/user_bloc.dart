import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserGetUsersEvent>(_onGetuser);
  }

  _onGetuser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(event.count, (index) => User(name: 'Gor', id: index.toString()));
    emit(UserLoadedState(users));
  }
}
