import 'package:fetch_api/screens/bookmark_list.dart';
import 'package:fetch_api/screens/drawingscreen.dart';
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
  HomeScreen({Key? key}) : super(key: key);

  final List<String> levels = [
    'jlptn5',
    'jlptn4',
    'jlptn3',
    'jlptn2',
    'jlptn1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kanji Levels',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookmarkList(),
                ),
              );
            },
            icon: const Icon(Icons.star, color: Colors.white),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
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
                  'JLPT Kanji Master',
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
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    level.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KhanjiListScreen(level: level),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E88E5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                title: Text(
                  'Master Kanji',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Best Way to Prepare for JLPT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: IconButton(
                  onPressed: null, // Leave blank for now
                  icon: Icon(Icons.search, size: 30, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Prevents scrolling within the ListView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.5,
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
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.blueAccent.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.book,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            levels[index].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
