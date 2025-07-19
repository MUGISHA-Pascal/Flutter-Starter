import 'package:flutter_starter/features/auth/domain/repository/auth_repository.dart';

class UserLogout {
  final AuthRepository authRepository;
  const UserLogout(this.authRepository);

  Future<void> call() async {
    await authRepository.logout();
  }
} 