//this model will conver User data to JSON than it will save to database

class User {
  String User_Name;
  String Email;
  String Password;

  //constructor
  User(
    this.User_Name,
    this.Email,
    this.Password,
  );

  factory User.fromJson(Map<String, dynamic> Json) => User(
        Json['User_Name'],
        Json['Email'],
        Json['Password'],
      );

  //converting user data to Json file
  //string is keyname and dynamic is value name

  Map<String, String> toJson() => {
        'User_Name': User_Name,
        'Email': Email,
        'Password': Password,
      };
}
