import 'package:heath_care/networks/auth.dart';
class Api{
  static const authUrl='http://10.0.2.2:8080';
  static String authKey= Auth().token;
}