final String tableUserModel = 'usermodel';


class UserModelFields{
  static final String userID = '_id';
  static final String userName = 'userName';
  static final String userDob = '0';
  static final String userDescription = 'userDescription';
  static final String userPicture = 'userPicture';
}

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