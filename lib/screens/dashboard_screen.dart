import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      List<dynamic> data = await ApiService.get_user();
      setState(() {
        users = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : users.isEmpty
              ? Center(child: Text("Tidak ada pengguna"))
              : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(users[index]['name'][0]),
                      ),
                      title: Text(users[index]['name']),
                      subtitle: Text(users[index]['email']),
                    ),
                  );
                },
              ),
    );
  }
}
