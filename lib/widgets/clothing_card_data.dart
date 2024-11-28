import 'package:flutter/material.dart';

class ClothingCardData extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final double price;

  const ClothingCardData({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.network(image, fit: BoxFit.contain, alignment: Alignment.bottomLeft)),
        Text("${name[0].toUpperCase()}${name.substring(1)}",
        style: const TextStyle(fontSize: 21, color: Colors.black87),
        ),
      ],
    );
  }
}