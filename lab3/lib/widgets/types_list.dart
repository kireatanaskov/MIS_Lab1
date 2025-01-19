import 'package:flutter/cupertino.dart';
import 'package:lab3/models/joke_type.dart';
import 'type_card.dart';

class TypesList extends StatefulWidget {
  final List<JokeType> types;
  const TypesList({super.key, required this.types});

  @override
  State<StatefulWidget> createState() => _TypesListState();
}

class _TypesListState extends State<TypesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10),
      children: widget.types.map((type) => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: TypeCard(
          type: type.type,
        ),
      )).toList(),
    );
  }
}