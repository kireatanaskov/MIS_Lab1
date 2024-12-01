import 'package:flutter/material.dart';

class DetailBackButton extends StatelessWidget {
  const DetailBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pop(context),
      tooltip: 'Back',
      label: const Text('Back'),
      icon: const Icon(Icons.arrow_back),
      backgroundColor: Colors.lightBlueAccent.shade100,
      shape: const StadiumBorder(),
    );
  }
}