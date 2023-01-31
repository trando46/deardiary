

class UserModel  {
  int userID;
  String userName;
  int userDob;
  String userDescription;
  String userPicture;

  UserModel({
    required this.userID,
    required this.userName,
    this.userDob = 0,
    this.userDescription = '',
    this.userPicture ='',
});








}