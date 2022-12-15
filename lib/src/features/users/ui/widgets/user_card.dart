import 'package:challenge_fudo/src/utils/shiny_card_style.dart';
import 'package:challenge_fudo/src/features/users/domain/user.dart';
import 'package:challenge_fudo/src/shared_widgets/shiny_card.dart';
import 'package:challenge_fudo/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.style,
  });

  final User user;
  final ShinyCardStyle style;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShinyCard(
          data: style,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserDataColumn(user: user),
                  IdColumn(user: user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IdColumn extends StatelessWidget {
  const IdColumn({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user.id.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Id",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class UserDataColumn extends StatelessWidget {
  const UserDataColumn({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "@${user.username}",
          style: const TextStyle(fontSize: 12),
        ),
        Text(user.name),
        kVerticalDivider,
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(
              Icons.business_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(user.company.name),
          ],
        ),
        kVerticalDivider,
        Text('"${user.company.catchPhrase}"'),
      ],
    );
  }
}
