// ignore_for_file: file_names

class UserData {
  String userName;
  String email;
  String password;
  String uid;
  UserData({
    required this.userName,
    required this.email,
    required this.password,
    required this.uid,
  });

  Map<String, dynamic> convert2Map() {
    return {
      'UserName': userName,
      'Email': email,
      'Password': password,
      'uid': uid,
    };
  }
}
