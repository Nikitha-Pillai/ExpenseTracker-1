import 'package:expense_tracker_1/main.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

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
      backgroundColor: Colors.black, // Set the background color to black
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Table(
            border: const TableBorder.symmetric(
              inside: BorderSide(color: Colors.grey, width: 0.5),
              outside: BorderSide(color: Colors.white, width: 1.0),
            ),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Fixed Expenses Section
              TableRow(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 155, 45), // Yellow background for "Fixed Expenses"
                ),
                children: const [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Fixed Expenses',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Black text for contrast
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var item in ['Rent/Mortgage', 'Electricity', 'Water', 'Gas', 'Internet', 'Phone'])
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white), // White text for items
                        ),
                      ),
                    ),
                    for (int i = 0; i < 3; i++)
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white), // Empty white text
                          ),
                        ),
                      ),
                  ],
                ),

              // Food Section
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade700, // Slightly brighter color
                ),
                children: const [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Food',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TableCell(child: SizedBox.shrink()),
                  TableCell(child: SizedBox.shrink()),
                  TableCell(child: SizedBox.shrink()),
                ],
              ),
              for (var item in ['Groceries', 'Coffee', 'Snacks'])
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    for (int i = 0; i < 3; i++)
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),

              // Transportation Section
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.purple.shade700,
                ),
                children: const [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Transportation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TableCell(child: SizedBox.shrink()),
                  TableCell(child: SizedBox.shrink()),
                  TableCell(child: SizedBox.shrink()),
                ],
              ),
              for (var item in ['Fuel', 'Maintenance', 'Parking Fees', 'Insurance', 'Public Transport'])
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    for (int i = 0; i < 3; i++)
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),

              // Entertainment Section
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade700,
                ),
                children: const [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Entertainment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TableCell(child: SizedBox.shrink()),
                  TableCell(child: SizedBox.shrink()),
                  TableCell(child: SizedBox.shrink()),
                ],
              ),
              for (var item in ['Movies', 'Concerts/Events', 'Hobbies', 'Restaurants', 'Parties', 'Leisure Travel'])
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    for (int i = 0; i < 3; i++)
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyPage(),
  ));
}
