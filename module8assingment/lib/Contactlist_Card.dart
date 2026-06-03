import 'package:flutter/material.dart';

class ContactListCard extends StatelessWidget {
  final String name;
  final String phone;

  const ContactListCard({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF0F0F0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.person,
          color: Color(0xFF5C4033),
          size: 36,
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          phone,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 13,
          ),
        ),
        trailing: const Icon(
          Icons.phone,
          color: Colors.blue,
          size: 26,
        ),
      ),
    );
  }
}