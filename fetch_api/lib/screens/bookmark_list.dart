import 'package:fetch_api/screens/khanji_detail_from_bookmark.dart';
import 'package:fetch_api/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:fetch_api/database/bookmark_database.dart';
import 'package:fetch_api/models/bookmarks.dart';

class BookmarkList extends StatefulWidget {
  const BookmarkList({super.key});

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  bool isLoading = false;
  List<Bookmarks> bookmarks = [];

  Future<void> getAllBookmarks() async {
    setState(() {
      isLoading = true;
    });

    try {
      bookmarks = await BookmarkDatabase.instance.readAllBookmarks();
      print("Fetched bookmarks: ${bookmarks.length}"); // Debug
    } catch (e) {
      // Handle error, if any
      print("Error loading bookmarks: $e");
    } finally {
      if (mounted) {
        // Ensure the widget is still mounted
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAllBookmarks(); // Initial load of bookmarks
  }

  @override
  void dispose() {
    BookmarkDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookmarks.isEmpty
              ? const Center(child: Text('No bookmarks found.'))
              : ListView.builder(
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 14, 50, 66),
                          child: Text(
                            bookmark.khanji ?? '',
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                        title: Text(
                          (bookmark.onyomi ?? '').split('\n').first.length > 12
                              ? '${(bookmark.onyomi ?? '').split('\n').first.substring(0, 12)}...'
                              : (bookmark.onyomi ?? '').split('\n').first,
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          (bookmark.meaning ?? '').split('\n').first.length > 35
                              ? '${(bookmark.meaning ?? '').split('\n').first.substring(0, 35)}...'
                              : (bookmark.meaning ?? '').split('\n').first,
                          style: const TextStyle(fontSize: 15),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[900]),
                          iconSize: 30.0,
                          onPressed: () async {
                            // Delete the bookmark
                            await BookmarkDatabase.instance
                                .deleteBookmark(bookmark.id!);

                            // Refresh the list
                            await getAllBookmarks();
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KhanjiDetailFromBookmarkScreen(
                                      khanjiId: bookmark.khanjiId!),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
