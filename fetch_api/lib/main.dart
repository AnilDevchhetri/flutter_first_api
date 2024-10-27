import 'package:flutter/material.dart';
import 'screens/khanji_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khanji App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> levels = [
    'jlptn5',
    'jlptn4',
    'jlptn3',
    'jlptn2',
    'jlptn1'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Khanji Levels',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1E88E5),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.white))
          ],
          iconTheme: const IconThemeData(color: Colors.white, size: 30)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1E88E5),
              ),
              child: Center(
                child: Text(
                  'JLPT Khanji Master',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            for (var level in levels)
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Color of the bottom border
                      width: 1.0, // Width of the bottom border
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(level.toUpperCase()),
                  onTap: () {
                    // Close the drawer before navigating
                    Navigator.pop(context);
                    // Navigate to the respective level screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KhanjiListScreen(level: level),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2,
          ),
          itemCount: levels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KhanjiListScreen(level: levels[index]),
                  ),
                );
              },
              child: Card(
                elevation: 4, // Creates shadow for the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    levels[index].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
