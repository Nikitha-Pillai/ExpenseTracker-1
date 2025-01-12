import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_1/main.dart';
import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => FormsState();
}

class FormsState extends State<Forms> {
  final Map<String, TextEditingController> controllers = {
    'Food': TextEditingController(),
    'Transport': TextEditingController(),
    'Entertainment': TextEditingController(),
    'Shopping': TextEditingController(),
    'Health': TextEditingController(),
    'Bills': TextEditingController(),
    'Studies': TextEditingController(),
    'Others': TextEditingController(),
  };

  final Map<String, String> documentIds = {};
final Map<String, Color> categoryColors = {

  'Food': const Color.fromARGB(255, 177, 32, 32),
  'Transport':const Color.fromARGB(255, 22, 43, 129),
  'Entertainment':const Color.fromARGB(255, 38, 147, 41),
  'Shopping': const Color.fromARGB(255, 163, 195, 46),
  'Health':  const Color.fromARGB(255, 32, 177, 162),
  'Bills': const Color.fromARGB(255, 129, 32, 177),
  'Studies':  const Color.fromARGB(255, 177, 32, 114),
  'Others': const Color.fromARGB(255, 177, 88, 32),
  
};

  @override
  void initState() {
    super.initState();
    _fetchBudgetData();
  }

  Future<void> _fetchBudgetData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("addBudget").get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final category = data['Category'] as String;
        final budget = data['Budget'].toString();

        if (controllers.containsKey(category)) {
          controllers[category]?.text = budget;
          documentIds[category] = doc.id;
        }
      }
    } catch (e) {
      print('Error fetching budget data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch budget data')),
      );
    }
  }

  Future<void> _saveBudget(String category) async {
    try {
      final controller = controllers[category];
      final budgetValue = int.tryParse(controller?.text ?? '') ?? 0;

      if (budgetValue <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid budget value')),
        );
        return;
      }

      final docId = documentIds[category];
      if (docId != null) {
        // Update the existing document
        await FirebaseFirestore.instance
            .collection("addBudget")
            .doc(docId)
            .update({'Budget': budgetValue});
      } else {
        // Add a new document if it doesn't exist
        final docRef = await FirebaseFirestore.instance.collection("addBudget").add({
          'Category': category,
          'Budget': budgetValue,
        });
        documentIds[category] = docRef.id;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Budget saved successfully')),
      );
    } catch (e) {
      print('Error saving budget: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save budget: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 78, 78),
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: controllers.entries.map((entry) {
                return Column(
                  children: [
                    _buildBudgetCard(entry.key, categoryColors[entry.key]!, entry.value),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetCard(
      String title, Color color, TextEditingController controller) {
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Enter your budget',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _saveBudget(title),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
