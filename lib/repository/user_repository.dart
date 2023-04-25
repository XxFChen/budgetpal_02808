import 'package:budgetpal/database/database_provider.dart';
import 'package:budgetpal/model/user.dart';

class UserRepository {
  final DatabaseProvider _databaseProvider;

  UserRepository(this._databaseProvider);

  Future<void> addUser(User user) async {
    // Add code to save user to the database
  }

  Future<User?> getUserByUsernameAndPassword(String username, String password) async {
    // Add code to retrieve user from the database using username and password
  }
}
