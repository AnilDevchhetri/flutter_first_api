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
  int totalPages = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchKhanjiList();
  }

  Future<void> fetchKhanjiList() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await KhanjiServices().getKhanjiList(widget.level, page: currentPage);
      setState(() {
        khanjiList = response['data'];
        totalPages = response['last_page'];
      });
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildPageButton(int page) {
    return TextButton(
      onPressed: () {
        setState(() {
          currentPage = page;
        });
        fetchKhanjiList();
      },
      child: Text(
        '$page',
        style: TextStyle(
          color: page == currentPage ? Colors.white : Colors.black,
          fontWeight: page == currentPage ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor:
            page == currentPage ? Colors.blue : Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget buildPagination() {
    List<Widget> pageButtons = [];

    int startPage = (currentPage - 2).clamp(1, totalPages);
    int endPage = (currentPage + 2).clamp(1, totalPages);

    if (startPage > 1) {
      pageButtons.add(buildPageButton(1));
      if (startPage > 2) pageButtons.add(const Text("..."));
    }

    for (int i = startPage; i <= endPage; i++) {
      pageButtons.add(buildPageButton(i));
    }

    if (endPage < totalPages) {
      if (endPage < totalPages - 1) pageButtons.add(const Text("..."));
      pageButtons.add(buildPageButton(totalPages));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageButtons,
      ),
    );
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
          if (totalPages > 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildPagination(),
            ),
        ],
      ),
    );
  }
}
