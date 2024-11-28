import 'package:flutter/material.dart';
import '../models/clothing.dart';
import '../widgets/detail_back_button.dart';
import '../widgets/detail_data.dart';
import '../widgets/detail_image.dart';
import '../widgets/detail_title.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Clothing;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            DetailImage(image: arguments.image),
            DetailTitle(id: arguments.id, name: arguments.name),
            DetailData(description: arguments.description, price: arguments.price),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const DetailBackButton(),
    );
  }
}