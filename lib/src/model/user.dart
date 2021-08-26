class AppUser {
  String userId;
  String email;
  String name;
  Roles role;

  AppUser({this.userId, this.email, this.name, this.role});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'role': role.index,
    };
  }

  AppUser.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'],
        name = json['name'],
        role = Roles.values[json['role']];
}

enum Roles { User, Employee, Admin }
