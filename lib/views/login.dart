import 'package:flutter/material.dart';
import '../services/SessionManager.dart';
import 'FavoriteCityScreen.dart'; // Import FavoriteCitiesScreen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SessionManager _sessionManager = SessionManager();
  List<String> _users = [];
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    var users = await _sessionManager.getAllUsers();
    setState(() {
      _users = users;
    });
  }

  void _deleteUser(String username) async {
    await _sessionManager.deleteUser(username);
    _loadUsers();
  }

  void _selectUser(String username) async {
    await _sessionManager.login(username);
    // Navigate to FavoriteCitiesScreen with the selected user
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteCitiesScreen(username: username),
      ),
    );
  }

  void _addUser() {
    if (_usernameController.text.isNotEmpty) {
      _sessionManager.createUser(_usernameController.text).then((_) {
        _usernameController.clear();
        _loadUsers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _users.isEmpty
          ? Center(
              child: Text(
                'No Users, create a new one!',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(_users[index]),
                    onTap: () => _selectUser(_users[index]),
                    onLongPress: () {
                      _deleteUser(_users[index]);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add User'),
                content: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter username',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      _addUser();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add User',
      ),
    );
  }
}
