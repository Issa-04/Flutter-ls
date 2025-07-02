import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/second': (context) => const SecondPage(),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildGridItem(String assetName) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          assetName,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Flutter project'),
          const MyText(text: 'Welcome to Flutter'),
          const SizedBox(height: 10),
          const Counter(),
          const SizedBox(height: 20),
          Text(
            'Roboto font',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          ),
          Text(
            'ShadowsInto font',
            style: const TextStyle(fontSize: 30, fontFamily: 'ShadowsInto'),
          ),
          Text(
            'Google font',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 1, 119, 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('Container')),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [Icon(Icons.star), Icon(Icons.settings)],
          ),
          const SizedBox(height: 20),
          const Text('🖼️image:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              buildGridItem('https://picsum.photos/200/300'),
              buildGridItem('https://picsum.photos/201/300'),
              buildGridItem('https://picsum.photos/202/300'),
              buildGridItem('https://picsum.photos/203/300'),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/second'),
            child: const Text('Go to Second Page (pushNamed)'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/detail', arguments: 'Page №1'),
            child: const Text('Go to Detail Page (pushNamed)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DetailPage()),
              );
            },
            child: const Text('Go to Detail (push)'),
          ),
          ElevatedButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: const Text('Try to pop (back)'),
          ),
        ],
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;
  const MyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  void _increment() => setState(() => count++);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(onPressed: _increment, child: const Text('Increment')),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: PageView(
        children: [
          Container(color: Colors.red),
          Container(color: Colors.green),
          Container(color: const Color.fromARGB(255, 0, 17, 255)),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments as String? ?? 'Тут нет данных';
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Stack(
        children: [
          Container(color: Colors.yellow),
          Positioned(
            top: 40,
            left: 20,
            child: Text(title, style: const TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
