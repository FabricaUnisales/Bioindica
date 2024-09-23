import 'package:bioindica/src/auth/domain/entities/user.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  User? user;

  AuthController({this.user});

  Future<void> login({required String email, required String password}) async {
    user = User(id: 1, name: 'Enrico Gollner', email: email, token: 'token');
    
  }

  Future<void> logout() async {
    // Do logout
  }
}
