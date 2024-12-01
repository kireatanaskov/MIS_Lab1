import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final int id;
  final String name;

  const DetailTitle({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20), // Adds 8 pixels of margin at the bottom
      child: Chip(
        backgroundColor: Colors.white,
        label: Text(
          name,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        labelPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

  }
}