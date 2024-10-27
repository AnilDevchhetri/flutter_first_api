import 'package:flutter/material.dart';
import '../models/khanji.dart';

class KhanjiDetailScreen extends StatelessWidget {
  final Khanji khanji;

  KhanjiDetailScreen({Key? key, required this.khanji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(khanji.khanji ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Meaning: ${khanji.meaning ?? 'No meaning'}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            if (khanji.strokeImageUrl != null &&
                khanji.strokeImageUrl!.isNotEmpty)
              Image.network(khanji.strokeImageUrl!),
            SizedBox(height: 10),
            Text("Examples:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            ...khanji.examples.map((example) {
              return ListTile(
                title: Text(example.khanjiSentence ?? ''),
                subtitle: Text(
                  "${example.exampleHiragana ?? ''} (${example.exampleRomaji ?? ''}) - ${example.exampleMeaning ?? ''}",
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
