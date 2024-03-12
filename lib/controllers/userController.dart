import 'package:http/http.dart' as http;

class UserController {
  static String uri = 'http://localhost:3000';

  Future getUserDetails({required String userId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/users/:$userId'),
        headers: {
          
        }
      );
      return response.body;
    } catch (e) {
      throw Exception('Failed to load user details');
    }
  }
}
