import 'package:challenge_fudo/src/shared_widgets/app_end_drawer.dart';
import 'package:challenge_fudo/src/utils/shiny_card_style.dart';
import 'package:challenge_fudo/src/features/users/domain/user.dart';
import 'package:challenge_fudo/src/features/users/ui/widgets/user_card.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class UsersLoadedView extends StatelessWidget {
  const UsersLoadedView({
    super.key,
    required this.users,
  });

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      endDrawer: const AppEndDrawer(),
      body: Material(
        textStyle: const TextStyle(color: Colors.white),
        child: ListView.separated(
          separatorBuilder: (context, index) => kVerticalDivider,
          itemBuilder: (context, index) => UserCard(
            style: ShinyCardStyle.all[index % 4],
            user: users[index],
          ),
          itemCount: users.length,
        ),
      ),
    );
  }
}
