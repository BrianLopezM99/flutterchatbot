import 'package:flutter/material.dart';
import 'package:flutterchatbot/widgets/dashboard/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: const <Widget>[
            DashboardItem(
              title: 'Users',
              icon: Icons.people,
              color: Colors.blue,
            ),
            DashboardItem(
              title: 'Messages',
              icon: Icons.message,
              color: Colors.green,
            ),
            DashboardItem(
              title: 'Settings',
              icon: Icons.settings,
              color: Colors.orange,
            ),
            DashboardItem(
              title: 'Analytics',
              icon: Icons.analytics,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
