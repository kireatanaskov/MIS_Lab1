import 'package:flutter/material.dart';
import 'package:lab_1/models/clothing.dart';
import 'package:lab_1/widgets/clothing_card_data.dart';

class ClothingCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;

  const ClothingCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        enableFeedback: true,
        splashColor: Colors.black12,
        onTap: () => {
          Navigator.pushNamed(context, "/details", arguments: Clothing(
              id: id,
              name: name,
              image: image,
              description: description,
              price: price))
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 10,
                blurRadius: 20,
                offset: const Offset(8, 4),
              ),
            ],
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)
          ),
          child: ClothingCardData(
              name: name,
              image: image,
              description: description,
              price: price),
        ),
      ),
    );
  }
}