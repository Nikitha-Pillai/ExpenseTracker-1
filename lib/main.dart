import 'dart:async';
import 'package:expense_tracker_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_1/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _imagePaths = [
    'assets/images/1.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/1.png',
    
  ];

  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    _startImageSlide();
  }

  void _startImageSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _imagePaths.length - 1) {
        setState(() {
          _currentIndex++;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        });
      } else {
        setState(() {
        });
        _timer.cancel(); // Stop the timer when the animation ends
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
      child: Container(
        width: 1500,
        height: 700,
        color: const Color.fromARGB(255, 0, 0, 0), // Simple background color
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _imagePaths.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _imagePaths[index],
                  fit: BoxFit.fill,
                );
              },
            ),
            Positioned(
              bottom: 28, // Adjust this value to bring the button further down
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePageWithNavbar(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: const Color.fromARGB(255, 46, 193, 198),
                    minimumSize: const Size(150, 50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text('Track Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
