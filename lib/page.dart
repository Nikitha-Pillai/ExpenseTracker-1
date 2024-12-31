import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

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
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance Card
            // Balance Card
Card(
  color: const Color.fromARGB(255, 79, 78, 78),
  margin: const EdgeInsets.all(16.0),
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Income text aligned to the left edge with some padding
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Income: \$8000',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ),
        ),
        // Balance text centered
        Expanded(
          child: Center(
            child: Text(
              'Balance: \$5000',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Expense text aligned to the right edge with some padding
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              'Expense: \$3000',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

            // Virtualized Scrollable Tables for Each Category
            const CategorySection(
              categoryName: 'Food',
              items: [
                {'item': 'Grocery', 'paidTo': 'Store A', 'date': '01/01/2024', 'amount': '\$150'},
                {'item': 'Snack', 'paidTo': 'Store B', 'date': '02/01/2024', 'amount': '\$50'},
                {'item': 'Ice Cream', 'paidTo': 'Store C', 'date': '03/01/2024', 'amount': '\$30'},
                {'item': 'Grocery', 'paidTo': 'Store A', 'date': '01/01/2024', 'amount': '\$150'},
                {'item': 'Snack', 'paidTo': 'Store B', 'date': '02/01/2024', 'amount': '\$50'},
                {'item': 'Ice Cream', 'paidTo': 'Store C', 'date': '03/01/2024', 'amount': '\$30'},
              ],
            ),
            const CategorySection(
              categoryName: 'Entertainment',
              items: [
                {'item': 'Movie', 'paidTo': 'Cinema', 'date': '01/01/2024', 'amount': '\$12'},
                {'item': 'Racing', 'paidTo': 'Track', 'date': '02/01/2024', 'amount': '\$100'},
                {'item': 'Comedy Show', 'paidTo': 'Club', 'date': '03/01/2024', 'amount': '\$25'},
                {'item': 'Movie', 'paidTo': 'Cinema', 'date': '01/01/2024', 'amount': '\$12'},
                {'item': 'Racing', 'paidTo': 'Track', 'date': '02/01/2024', 'amount': '\$100'},
                {'item': 'Comedy Show', 'paidTo': 'Club', 'date': '03/01/2024', 'amount': '\$25'},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String categoryName;
  final List<Map<String, String>> items;

  const CategorySection({required this.categoryName, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    // Create a ScrollController
   // final ScrollController _scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
         Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10), // Applied to the outer container
    color: const Color.fromARGB(255, 79, 78, 78),
  ),
  child: SizedBox(
    width: double.infinity,
    height: 250,
    child: Column(
      children: [
        // Fixed Header Row
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Keep the rounded corners for header
            color: const Color.fromARGB(255, 59, 58, 58),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Item', style: TextStyle(color: Colors.white)))),
              Expanded(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Paid To', style: TextStyle(color: Colors.white)))),
              Expanded(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Date', style: TextStyle(color: Colors.white)))),
              Expanded(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Amount', style: TextStyle(color: Colors.white)))),
            ],
          ),
        ),
        // Scrollable Rows (no rounded corners for individual rows)
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: items.map((item) {
                return Container(
                  color: const Color.fromARGB(255, 100, 100, 100), // No borderRadius here
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(item['item']!, style: const TextStyle(color: Colors.white)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(item['paidTo']!, style: const TextStyle(color: Colors.white)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(item['date']!, style: const TextStyle(color: Colors.white)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(item['amount']!, style: const TextStyle(color: Colors.white)))),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    ),
  ),
)

        ],
      ),
    );
  }
}
