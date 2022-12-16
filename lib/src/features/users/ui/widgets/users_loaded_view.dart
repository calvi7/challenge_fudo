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
        child: BuildCardsBasedOnConstraints(users: users),
      ),
    );
  }
}

class BuildCardsBasedOnConstraints extends StatelessWidget {
  const BuildCardsBasedOnConstraints({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => kVerticalDivider,
            itemBuilder: (context, index) => UserCard(
              style: ShinyCardStyle.all[index % 4],
              user: users[index],
            ),
            itemCount: users.length,
          );
        } else {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.5,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) => UserCard(
                  user: users[index],
                  style: ShinyCardStyle.all[index % 4],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
