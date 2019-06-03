class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String address;
  final String phoneNumber;
  final String nextOfKin;
  final String nextOfKinPhoneNumber;

  User(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.address,
      this.phoneNumber,
      this.nextOfKin,
      this.nextOfKinPhoneNumber});
}

class UserInstance {
  static final UserInstance _userInstance = new UserInstance._internal();

  User user = User();

  factory UserInstance() {
    return _userInstance;
  }

  UserInstance._internal();
}

final userInstance = UserInstance();
