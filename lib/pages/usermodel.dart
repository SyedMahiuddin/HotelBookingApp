

class UserModel {
  String? uid;
  String? email;

  UserModel(
      {this.uid,
        this.email,
      });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'],
    email: map['email'],
  );
}
