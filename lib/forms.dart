import 'package:expense_tracker_1/main.dart';
import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => FormsState();
}

class FormsState extends State<Forms> {
 final TextEditingController foodController=TextEditingController();
 final TextEditingController transportController=TextEditingController();
 final TextEditingController entertainmentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 78, 78),
        title: const Text('Expense Tracker',style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () { Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyApp()));
                },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
            _buildBudgetCard('Food',const Color.fromARGB(255, 177, 32, 32),foodController,),
            const SizedBox(height: 20),
            _buildBudgetCard('Transport',const Color.fromARGB(255, 22, 43, 129),transportController),
            const SizedBox(height: 20),
            _buildBudgetCard('Entertainment',const Color.fromARGB(255, 38, 147, 41),entertainmentController),
            const Spacer(),
            const SizedBox(height: 2.5),
           SizedBox(
  width: MediaQuery.of(context).size.width * 0.2, // 80% of screen width
  child: ElevatedButton.icon(
  onPressed: () {
    // print('Add budget pressed');
  },
  icon: const Icon(Icons.add, color: Colors.white),
  label: const Text(
    'Add Budget',
    style: TextStyle(color: Colors.white),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(vertical: 20),
    side: const BorderSide(color: Colors.white, width: 2), // White border
  ),
),
          ),
          ],
          ),),
      ),
    );
  }

Widget _buildBudgetCard(String title, Color color, TextEditingController controller) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white), // Set text color
            decoration: const InputDecoration(
              labelText: 'Enter your budget',
              labelStyle: TextStyle(color: Colors.white), // Set label color
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Set border color
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Border when enabled
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2), // Border when focused
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // print('$title budget saved: ${controller.text}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // print('$title budget updated: ${controller.text}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

 @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    foodController.dispose();
    transportController.dispose();
    entertainmentController.dispose();
    super.dispose();
  }
}

