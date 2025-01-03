import 'package:cloud_firestore/cloud_firestore.dart';
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
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("transactions").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No transactions available',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final transactions = snapshot.data!.docs;
                double totalIncome = 0;
                double totalExpense = 0;

                for (var doc in transactions) {
                  final data = doc.data() as Map<String, dynamic>;
                  final amount = data['Amount'] ?? 0;
                  final type = data['Transaction Type'] ?? '';

                  if (type == 'Income') {
                    totalIncome += amount;
                  } else if (type == 'Expense') {
                    totalExpense += amount;
                  }
                }

                final balance = totalIncome - totalExpense;

                return Card(
                  color: const Color.fromARGB(255, 79, 78, 78),
                  margin: const EdgeInsets.all(16.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Income: \$${totalIncome.toStringAsFixed(2)}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Balance: \$${balance.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Expense: \$${totalExpense.toStringAsFixed(2)}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const CategorySection(categoryName: 'Food'),
            const CategorySection(categoryName: 'Transport'),
            const CategorySection(categoryName: 'Entertainment'),
            const CategorySection(categoryName: 'Shopping'),
            const CategorySection(categoryName: 'Health'),
            const CategorySection(categoryName: 'Bills'),
         //   const CategorySection(categoryName: 'Earnings'),
            const CategorySection(categoryName: 'Studies'),
            const CategorySection(categoryName: 'Others'),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String categoryName;

  const CategorySection({required this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection("transactions")
          .where("Category", isEqualTo: categoryName)
          .where("Transaction Type", isEqualTo: "Expense")
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No transactions for $categoryName",
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final transactions = snapshot.data!.docs;

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
                  borderRadius: BorderRadius.circular(10),
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
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 59, 58, 58),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Transaction Details',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Date',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Amount',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Scrollable Rows
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: transactions.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              return Container(
                                color: const Color.fromARGB(255, 100, 100, 100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data['Transaction Details'] ?? '',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data['Date'] ?? '',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data['Amount']?.toString() ?? '',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
