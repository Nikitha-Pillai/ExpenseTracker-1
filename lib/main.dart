import 'package:expense_tracker_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_1/homepage.dart';

void main() async{
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
      //theme: ThemeData.dark(),
     // themeMode: ThemeMode.dark,
      home: MyHomePage(title: 'Flutter Demo Homepage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 78, 78),
        title: const Text('Expense Tracker',style: TextStyle(color: Colors.white),),
       
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading below AppBar
              const Center(
                child: Text(
                  'Track Your Expense Now',
                  style:  TextStyle(color: Colors.white,fontSize: 24)
                ),
              ),
              const SizedBox(height: 50),
        
              // Row to show the card with image and buttons on the right
            Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
          children: [
            // Left side: Card with image
            Padding(
        padding: const EdgeInsets.only(left: 250.0), // Add padding to push the card to the right
        child: Card(
          elevation: 4,
          child: SizedBox(
            width: 500,
            height: 500,
            child: Image.asset('assets/images/chart.png', fit: BoxFit.cover),
          ),
        ),
            ),
        
            // Right side: Buttons
          Padding(
  padding: const EdgeInsets.only(left: 300.0), // Add padding to move buttons to the right
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Sign Up button
      ElevatedButton(
        onPressed: () {
          // Add Sign Up functionality here
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.black, minimumSize: const Size(200, 60), // White text
          side: const BorderSide(color: Colors.white), // White border
        ),
        child: const Text('Sign Up'),
      ),
      const SizedBox(height: 30),
      // Continue button
      ElevatedButton(
        onPressed: () {
          // Navigate to ExpenseTrackerApp page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExpenseTrackerApp(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.black, minimumSize: const Size(200, 60), // White text
          side: const BorderSide(color: Colors.white), // White border
        ),
        child: const Text('Continue'),
      ),
    ],
  ),
)

        
          ],
        ),
        
            ],
          ),
        ),
      ),
    );
  }
}
