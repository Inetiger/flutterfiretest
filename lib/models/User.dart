import 'package:uuid/uuid.dart';

class User {
  String name;
  final String userId;

  User({required this.name}) : userId = const Uuid().v4();

  @override
  String toString() {
    return 'User(name: $name, userId: $userId)';
  }
}
