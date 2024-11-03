import 'package:fetch_api/screens/drawingscreen.dart';
import 'package:flutter/material.dart';
import '../models/khanji.dart';

class KhanjiDetailScreen extends StatelessWidget {
  final Khanji khanji;

  KhanjiDetailScreen({Key? key, required this.khanji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          khanji.khanji ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Drawingscreen()));
        },
        backgroundColor: Color(0xFF1E88E5),
        child: Icon(
          Icons.draw_sharp,
          color: Colors.white,
        ),
        elevation: 6,
        tooltip: 'Practice',
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Large Kanji character in the center with shadow
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 2, 25, 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26, // Color of the shadow
                          offset:
                              Offset(0, 2), // Positioning of the shadow (x, y)
                          blurRadius: 6.0, // Softness of the shadow
                          spreadRadius: 1.0, // How much the shadow spreads
                        ),
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, -2), // Shadow on the top
                          blurRadius: 6.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      khanji.khanji ?? '',
                      style: const TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //Stroke image with horizontal scrolling if needed
                if (khanji.strokeImageUrl != null &&
                    khanji.strokeImageUrl!.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Image.network(
                      khanji.strokeImageUrl!,
                      fit: BoxFit.contain,
                    ),
                  ),
                const SizedBox(height: 20),

                // Details card with padding
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  elevation: 4.0, // Set elevation to create shadow

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                            "Meaning", khanji.meaning ?? 'No meaning'),
                        _buildDetailRow("Onyomi", khanji.onyomi ?? 'N/A'),
                        _buildDetailRow("Kunyomi", khanji.kunyomi ?? 'N/A'),
                        _buildDetailRow(
                            "Strokes", khanji.strokCount?.toString() ?? 'N/A'),
                        _buildDetailRow("JLPT", khanji.jlptLevel ?? 'N/A'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Onyomi Words",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _cardDetail(context, khanji.onyomiWords ?? 'N/A'),
                const SizedBox(height: 20),
                const Text(
                  "Kunyomi Words",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _cardDetail(context, khanji.kunyomiWords ?? 'N/A'),
                const SizedBox(height: 20),
                const Text(
                  "Some Special Words",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _cardDetail(context, khanji.specialWords ?? 'N/A'),
                const SizedBox(height: 20),

                // Examples section
                const Text(
                  "Examples",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                Column(
                  children: khanji.examples.asMap().entries.map((entry) {
                    int index = entry.key; // Index of the item
                    var example = entry.value; // Example item itself

                    return Container(
                      width: MediaQuery.of(context).size.width - 8,
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Kanji Sentence
                              Container(
                                width: MediaQuery.of(context).size.width - 8,
                                color:
                                    Colors.green, // Background color for Kanji
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '#${index + 1}. ${example.khanjiSentence ?? ''}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color:
                                        Colors.white, // Text color for contrast
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Hiragana
                              _buildDetailWithBackground(
                                context,
                                "Hiragana",
                                example.exampleHiragana ?? '',
                                Colors.blue[
                                    100], // Light blue background for Hiragana
                              ),

                              // Romaji
                              _buildDetailWithBackground(
                                context,
                                "Romaji",
                                example.exampleRomaji ?? '',
                                Colors.orange[
                                    100], // Light orange background for Romaji
                              ),

                              // Meaning
                              _buildDetailWithBackground(
                                context,
                                "Meaning",
                                example.exampleMeaning ?? '',
                                Colors.yellow[
                                    100], // Light yellow background for Meaning
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build each detail row with light color box for the title

  Widget _buildDetailRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text at the start
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            // Allows content to take available space
            child: Text(
              content,
              overflow: TextOverflow.ellipsis, // Prevent overflow with ellipsis
              maxLines: 15, // Limit the number of lines to 2
              style: const TextStyle(), // You can add your desired text style
            ),
          ),
        ],
      ),
    );
  }

// Helper method to build a section with title and content with background
  Widget _buildDetailWithBackground(
      BuildContext context, String title, String content, Color? bgColor) {
    return Container(
      width: MediaQuery.of(context).size.width - 8, // Match the card width
      color: bgColor,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(content),
        ],
      ),
    );
  }

  Widget _cardDetail(
    BuildContext context,
    String content,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width - 8, // Match the card width
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        elevation: 4.0, // Set elevation to create shadow

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(content),
        ),
      ),
    );
  }
}
