import 'package:flutter/material.dart';
import '../models/khanji.dart';
import '../services/khanji_services.dart';
import 'khanji_detail_screen.dart';

class KhanjiListScreen extends StatelessWidget {
  final String level;

  KhanjiListScreen({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khanji List - $level"),
      ),
      body: FutureBuilder<List<Khanji>>(
        future: KhanjiServices().getKhanjiList(level),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error fetching Khanji data"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Khanji found"));
          }

          var khanjiList = snapshot.data!;

          return ListView.builder(
            itemCount: khanjiList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(khanjiList[index].khanji ?? ''),
                subtitle: Text(khanjiList[index].meaning ?? 'No meaning'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          KhanjiDetailScreen(khanji: khanjiList[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
