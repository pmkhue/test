import 'package:flutter/material.dart';

void main() {
  runApp(const PuzzleApp());
}

class PuzzleApp extends StatelessWidget {
  const PuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliding Puzzle',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PuzzlePage(),
    );
  }
}

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  late List<int> tiles;

  @override
  void initState() {
    super.initState();
    tiles = List<int>.generate(16, (index) => index);
  }

  bool get isSolved => List.generate(16, (i) => i).every((i) => tiles[i] == i);

  void onTileTap(int index) {
    final int emptyIndex = tiles.indexOf(0);
    if (_isAdjacent(index, emptyIndex)) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
      });
      if (isSolved) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('You win!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  bool _isAdjacent(int a, int b) {
    final rowA = a ~/ 4;
    final colA = a % 4;
    final rowB = b ~/ 4;
    final colB = b % 4;
    return (rowA == rowB && (colA - colB).abs() == 1) ||
        (colA == colB && (rowA - rowB).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding Puzzle'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            itemCount: 16,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: tiles[index] != 0 ? () => onTileTap(index) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: tiles[index] == 0 ? Colors.grey[300] : Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: tiles[index] == 0
                        ? const SizedBox.shrink()
                        : Text(
                            tiles[index].toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            tiles.shuffle();
          });
        },
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
