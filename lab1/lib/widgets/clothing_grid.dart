import 'package:flutter/cupertino.dart';
import 'package:lab_1/models/clothing.dart';
import 'package:lab_1/widgets/clothing_card.dart';

class ClothingGrid extends StatefulWidget {
  final List<Clothing> clothing;

  const ClothingGrid({super.key, required this.clothing});

  @override
  _ClothingGridState createState() => _ClothingGridState();
}

class _ClothingGridState extends State<ClothingGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      crossAxisCount: 1,
      mainAxisSpacing: 20,
      childAspectRatio: 200 / 230,
      // physics: const BouncingScrollPhysics(),
      children: widget.clothing.map((clothing) =>
        ClothingCard(
          id: clothing.id,
          name: clothing.name,
          image: clothing.image,
          description: clothing.description,
          price: clothing.price
        ),).toList(),
    );
  }

}