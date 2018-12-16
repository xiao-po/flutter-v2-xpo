import 'package:dio/dio.dart';
import 'package:v2_xpo/model/model.dart';

class UserService {
  const UserService();

 Future<User> getUserByName(String name) async {
    Dio dio =  new  Dio();
    try {
      print(name);
      Response response =await dio.get(_UserApi.member + "?username=" +  name);

      return User.fromJSON(response.data);
    } catch(e) {
      print ( name + 'userService error');
    }
    return null;
  }
}

class _UserApi {
  static String member =  "https://www.v2ex.com/api/members/show.json";
}
