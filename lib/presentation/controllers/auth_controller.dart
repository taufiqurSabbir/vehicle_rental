import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../data/models/auth_utility.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  Future<UserModel?> UserData() async {
    isLoading.value = true;
    UserModel? fetchedUser = await AuthUtlity.getUserInfo();
    print(fetchedUser?.id);
    try {
      final result = await APICaller().getrequest(ApiEndPoint.loginUser(fetchedUser!.id!));
      print(result);

      final dynamic data = result['data'];
      final loggedInUser = UserModel.fromJson(data);
      await AuthUtlity.saveUserInfo(loggedInUser);
      user.value = loggedInUser;
      return loggedInUser;

      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }


  Future<UserModel?> login(String email, String password) async {
    isLoading.value = true;

    try {
      final result = await APICaller().getrequest(ApiEndPoint.login);
      print(result);

      final dynamic data = result['data'];

      if (data is List) {
        for (var item in data) {
          if (item['email'] == email && item['password'] == password) {
            final loggedInUser = UserModel.fromJson(item);
            await AuthUtlity.saveUserInfo(loggedInUser);
            user.value = loggedInUser;
            return loggedInUser;
          }
        }
      }

      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
