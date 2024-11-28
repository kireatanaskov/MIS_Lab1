import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lab_1/models/clothing.dart';
import 'package:lab_1/widgets/clothing_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Clothing> generateClothingList() {
  List<String> imageUrls = [
    "https://isto.pt/cdn/shop/files/Heavyweight_Black_ef459afb-ff7a-4f9a-b278-9e9621335444.webp?v=1710414950",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-a2GmhwWUGGFmRZhMuMTxFThJO0Lsxiwu6w&s",
    "https://hooke.ca/cdn/shop/files/HOOKE-MEN-LIGHTWEIGHT-INSULATED-HOOD-JACKET-BLK-1.webp?v=1689773252&width=2500",
  ];

  List<String> names = [
    "T-shirt",
    "Trousers",
    "Jacket",
  ];

  final random = Random();
  return List.generate(3, (index) => Clothing(
      id: index,
      name: names[index],
      description: "Description for ${names[index]}",
      price: random.nextDouble() * 100,
      image: imageUrls[index]));
}

class _HomeState extends State<Home> {
  final random = Random();

  List<Clothing> clothing = generateClothingList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,
          title: const Text("213132", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
        ),
      body: ClothingGrid(clothing: clothing),
    );
  }
}