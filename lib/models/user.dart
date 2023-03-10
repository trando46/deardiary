final String tableUserModel = 'usermodel';

class UserModelFields {
  static final String userID = '_id';
  static final String userName = 'userName';
  static final String userDob = 'userDob';
  //static final String userDescription = 'userDescription';
  static final String email = 'email';
  //static final String userPicture = 'userPicture';
}

class UserModel {
  String userID;
  String userName;
  String userDob;
  //String userDescription;
  String email;
  //String userPicture;

  UserModel({
    required this.userID,
    required this.userName,
    required this.userDob,
    //this.userDescription = '',
    required this.email,
    //this.userPicture = '',
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : userID = json[UserModelFields.userID],
        userName = json[UserModelFields.userName],
        userDob = json[UserModelFields.userDob],
        //userDescription = json[UserModelFields.userDescription],
        email = json[UserModelFields.email];
  //userPicture = json[UserModelFields.userPicture];

  Map<String, dynamic> toJson() => {
        UserModelFields.userID: userID,
        UserModelFields.userName: userName,
        UserModelFields.userDob: userDob,
        //UserModelFields.userDescription: userDescription,
        UserModelFields.email: email,
        //UserModelFields.userPicture: userPicture,
      };
}
