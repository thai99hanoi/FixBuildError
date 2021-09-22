import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';

class UserRepository{
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  Future<User> getCurrentUser() async {
    Map<String, dynamic> response = await apiBaseHelper.get("/api/v1/current-user");
    var entriesList = response.entries.toList();
    return User.fromMap(entriesList[1].value);
  }

  Future<List<User>?> getUserOnline(userId) async {
    List<User>? userOnline;
    Map<String, dynamic> response = await apiBaseHelper.get("/api/v1/users-online"+userId);
    var entriesList = response.entries.toList();
    for(User user in entriesList[1].value){
      userOnline!.add(user);
    }
    return userOnline;
  }
}