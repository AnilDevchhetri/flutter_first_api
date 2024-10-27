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
        title: Text(
          "Khanji List - ${widget.level}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: khanjiList.length,
                    itemBuilder: (context, index) {
                      final khanjiData = khanjiList[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 14, 50, 66),
                            child: Text(khanjiData.khanji ?? '',
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.white)),
                          ),
                          title: Text(
                            (khanjiData.onyomi ?? '').split('\n').first.length >
                                    12
                                ? '${(khanjiData.onyomi ?? '').split('\n').first.substring(0, 12)}...'
                                : (khanjiData.onyomi ?? '').split('\n').first,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            (khanjiData.meaning ?? '')
                                        .split('\n')
                                        .first
                                        .length >
                                    35
                                ? '${(khanjiData.meaning ?? '').split('\n').first.substring(0, 35)}...'
                                : (khanjiData.meaning ?? '').split('\n').first,
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.star_border,
                                    color: Colors.yellow),
                                iconSize: 30.0,
                                onPressed: () {
                                  // Handle star action
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KhanjiDetailScreen(
                                    khanji: khanjiList[index]),
                              ),
                            );
                          },
                        ),
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
                    icon: const Icon(Icons.arrow_back),
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
                    icon: const Icon(Icons.arrow_forward),
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
