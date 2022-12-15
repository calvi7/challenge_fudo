import 'package:challenge_fudo/src/features/users/data/users_repository.dart';
import 'package:challenge_fudo/src/features/users/domain/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends HydratedBloc<UsersEvent, UsersState> {
  final UsersRepository _repository;

  UsersBloc(this._repository) : super(UsersInitial()) {
    on<UsersFetched>(_onUsersFetched);
  }

  Future<void> _onUsersFetched(
    UsersFetched event,
    Emitter<UsersState> emit,
  ) async {
    try {
      if (state is UsersLoaded) {
        return;
      }
      emit(UsersLoading());
      final users = await _repository.getUsers();
      emit(UsersLoaded(users));
    } on Exception catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  @override
  UsersState? fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      final users = usersFromJson(json['users']);
      return UsersLoaded(users);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(UsersState state) {
    if (state is UsersLoaded) {
      final users = usersToJson(state.users);
      return {'users': users};
    }
    return null;
  }
}
