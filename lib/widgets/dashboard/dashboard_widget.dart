import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          SnackBar snackBar = const SnackBar(
            content: Text('Hola, esto solo es un layout de prueba :)'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 50.0,
                color: Colors.white,
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
