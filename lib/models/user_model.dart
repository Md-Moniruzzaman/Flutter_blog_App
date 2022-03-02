class UserModel {
  String? title;
  String? content;

  UserModel({this.title, this.content});

  //data receive from server
  factory UserModel.fromMap(map) {
    return UserModel(
      title: map('title'),
      content: map('conten'),
    );
  }
}
