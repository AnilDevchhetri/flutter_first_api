import 'package:flutter/material.dart';
import '../models/khanji.dart';
import '../services/khanji_services.dart';
import 'khanji_detail_screen.dart';

class KhanjiListScreen extends StatefulWidget {
  final String level;

  KhanjiListScreen({Key? key, required this.level}) : super(key: key);

  @override
  _KhanjiListScreenState createState() => _KhanjiListScreenState();
}

class _KhanjiListScreenState extends State<KhanjiListScreen> {
  List<Khanji> khanjiList = [];
  int currentPage = 1;
  int totalPages = 1; // Keep track of total pages
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchKhanjiList();
  }

  Future<void> fetchKhanjiList() async {
    if (isLoading) return; // Prevent multiple requests
    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await KhanjiServices().getKhanjiList(widget.level, page: currentPage);
      setState(() {
        khanjiList = response['data'];
        totalPages = response[
            'last_page']; // Get the total number of pages from response
      });
    } catch (e) {
      // Handle error
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khanji List - ${widget.level}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
            ),
          ),
          // Pagination controls
          if (totalPages > 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: currentPage > 1
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                            fetchKhanjiList();
                          }
                        : null,
                  ),
                  Text("Page $currentPage of $totalPages"),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: currentPage < totalPages
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                            fetchKhanjiList();
                          }
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
