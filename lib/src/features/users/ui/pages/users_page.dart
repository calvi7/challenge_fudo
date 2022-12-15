import 'package:challenge_fudo/src/features/posts/bloc/posts_bloc.dart';
import 'package:challenge_fudo/src/features/users/bloc/users_bloc.dart';
import 'package:challenge_fudo/src/features/users/data/users_repository.dart';
import 'package:challenge_fudo/src/features/users/ui/widgets/users_loaded_view.dart';
import 'package:challenge_fudo/src/shared_widgets/exception_occurred_widget.dart';
import 'package:challenge_fudo/src/shared_widgets/loading_widget.dart';
import 'package:challenge_fudo/src/utils/show_toast.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersBloc(GetIt.I<UsersRepository>())..add(UsersFetched()),
      child: BlocConsumer<UsersBloc, UsersState>(
        listener: _listener,
        builder: (context, state) {
          if (state is UsersLoaded) {
            return Center(
              child: UsersLoadedView(
                users: state.users,
              ),
            );
          } else if (state is PostsLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is UsersError) {
            return Center(
              child: ExceptionOccurredWidget(
                onRetry: () => context.read<UsersBloc>().add(UsersFetched()),
              ),
            );
          } else {
            return kEmptyWidget;
          }
        },
      ),
    );
  }

  void _listener(BuildContext context, UsersState state) {
    if (state is UsersError) {
      showErrorToast(context, state.message);
    }
  }
}
