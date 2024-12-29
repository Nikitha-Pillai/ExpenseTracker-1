import 'dart:collection';
import 'package:expense_tracker_1/main.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  ExpenseTrackerScreenState createState() => ExpenseTrackerScreenState();
}

class ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  IconLabel? selectedCategory;
  final TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format the date as needed
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

  void _addExpense() {
    
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Amount Spent',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    color: Colors.white,
                    onPressed: () => _selectDate(context), // Date picker appears immediately
                  ),
                ),
                readOnly: true, // Make field read-only, so the date picker triggers
                onTap: () => _selectDate(context), // Trigger date picker when field is tapped
              ),
              const SizedBox(height: 8),
              TextField(
                controller: timeController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Time',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    color: Colors.white,
                    onPressed: () => _selectTime(context), // Time picker appears immediately
                  ),
                ),
                readOnly: true, // Make field read-only, so the time picker triggers
                onTap: () => _selectTime(context), // Trigger time picker when field is tapped
              ),
              const SizedBox(height: 8),
              const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Paid To',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 8),
                  DropdownButton<IconLabel>( 
                    value: selectedCategory,
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(color: Colors.white),
                    ),
                    items: IconLabel.entries
                        .map(
                          (entry) => DropdownMenuItem<IconLabel>( 
                            value: entry.value,
                            child: Row(
                              children: [
                                Icon(entry.value.icon, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  entry.value.label,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (IconLabel? category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    dropdownColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (selectedCategory != null)
                Text(
                  'Selected Category: ${selectedCategory?.label}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _addExpense,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 37, 37, 37), // Button color
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Add the Expense',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum IconLabel {
  food('Food', Icons.food_bank),
  transport('Transport', Icons.directions_bus),
  shopping('Shopping', Icons.shopping_bag),
  health('Health', Icons.local_hospital),
  bills('Bills', Icons.receipt_long),
  others('Others', Icons.miscellaneous_services);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;

  static final List<DropdownMenuEntry<IconLabel>> entries =
      UnmodifiableListView(
    values.map<DropdownMenuEntry<IconLabel>>(
      (IconLabel iconLabel) => DropdownMenuEntry<IconLabel>(
        value: iconLabel,
        label: iconLabel.label,
        leadingIcon: Icon(iconLabel.icon),
      ),
    ),
  );
}