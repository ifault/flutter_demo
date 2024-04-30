import 'package:flutter/material.dart';

class MyDarwerTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;

  const MyDarwerTile(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(text),
        leading: Icon(icon, color: Theme.of(context).colorScheme.inversePrimary),
        onTap: onTap,
      ),
    );
  }
}
