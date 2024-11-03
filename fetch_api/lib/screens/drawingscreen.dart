import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

class Drawingscreen extends StatefulWidget {
  const Drawingscreen({super.key});

  @override
  State<Drawingscreen> createState() => _DrawingscreenState();
}

class _DrawingscreenState extends State<Drawingscreen> {
  late DrawingController _drawingController;

  @override
  void initState() {
    super.initState();
    _drawingController = DrawingController();
  }

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }

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
            onPressed: () {},
            icon: const Icon(Icons.star, color: Colors.white),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Stack(
        children: [
          // DrawingBoard takes up the full screen space
          Positioned.fill(
            child: DrawingBoard(
              controller: _drawingController,
              background: Container(
                color: Colors.white,
              ),
              showDefaultActions: true,
              showDefaultTools: true,
              defaultToolsBuilder:
                  (Type currentType, DrawingController controller) {
                // Get the default tools and remove specific ones by index
                List<DefToolItem> tools =
                    DrawingBoard.defaultTools(currentType, controller);

                // Remove unwanted tools like rectangle and circle
                if (tools.length > 2) tools.removeAt(2); // Remove rectangle
                if (tools.length > 1) tools.removeAt(1); // Remove circle

                return tools;
              },
            ),
          ),
          // Fixed positioned container
          Positioned(
            top: 50, // Adjust as needed
            left: 50, // Adjust as needed
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blueAccent.withOpacity(0.3),
              child: const Center(
                child: Text(
                  'Fixed Position Container',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
