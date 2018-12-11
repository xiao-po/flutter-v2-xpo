import 'package:dio/dio.dart';
import 'package:v2_xpo/model/Node.dart';

class UserService {
  const UserService();

 Future<User> getUserByName(String name) async {
    Dio dio =  new  Dio();
    try {
      print(name);
      Response<User> response =await dio.get(_UserApi.Merber + "?username=" +  name);
      return response.data;
    } catch(e) {
      print ( name + 'userService error');
    }
    return null;
  }
}

class _UserApi {
  static String Merber =  "https://www.v2ex.com/api/members/show.json";
}
