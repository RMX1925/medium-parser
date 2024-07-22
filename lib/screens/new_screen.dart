import 'package:flutter/material.dart';
import 'package:myapp/modals/medium_modal.dart';

class MediumParseScreen extends StatefulWidget {
  const MediumParseScreen({
    super.key,
    required this.mediumData,
  });
  final MediumArticleData mediumData;
  @override
  State<MediumParseScreen> createState() => _MediumParseScreenState();
}

class _MediumParseScreenState extends State<MediumParseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            widget.mediumData.content.isEmpty ? "Empty" : " Not empty",
          ),
        ],
      ),
    );
  }
}
