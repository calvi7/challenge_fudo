import 'package:challenge_fudo/src/utils/durations.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  @visibleForTesting
  final kValidUsername = "challenge@fudo";

  @visibleForTesting
  final kValidPassword = "password";

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    await Future.delayed(Durations.ms500);
    return username == kValidUsername && password == kValidPassword;
  }
}
