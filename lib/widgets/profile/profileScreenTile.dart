import 'package:flutter/material.dart';

class ProfileScreenTile extends StatelessWidget {
  const ProfileScreenTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              40.0,
            ),
            color: Colors.grey.withOpacity(0.1)),
        child: Icon(
          icon,
          color: Colors.blueAccent,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              40.0,
            ),
            color: Colors.grey.withOpacity(0.1)),
        child: Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
      ),
    );
  }
}
