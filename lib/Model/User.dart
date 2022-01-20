
class UserFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String isBeginner = 'isBeginner';

  static List<String> getFields() => [id, name, email, isBeginner];
}

class User{
  final int? id;
  final String name;
  final String email;
  final bool isBeginner;

  const User({this.id, required this.name,required this.email,required this.isBeginner});

  Set<String> toJson() => {
    UserFields.id,
    UserFields.name,
    UserFields.email,
    UserFields.isBeginner,
  };
}
