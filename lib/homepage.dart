import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_1/exp.dart';
import 'package:expense_tracker_1/forms.dart';
import 'package:expense_tracker_1/main.dart';
import 'package:expense_tracker_1/page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
 import 'package:intl/intl.dart'; 

class HomePageWithNavbar extends StatefulWidget {
  const HomePageWithNavbar({super.key});

  @override
  State<HomePageWithNavbar> createState() => _HomePageWithNavbarState();
}
class _HomePageWithNavbarState extends State<HomePageWithNavbar> {
  int _currentPage = 0;
  final GlobalKey<CurvedNavigationBarState> _curvedNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    const HomePage(),
    const ExpenseTrackerScreen(),
    const MyPage(),
    const Forms(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: CurvedNavigationBar(
        key: _curvedNavigationKey,
        index: 0,
        height: 65.0,
        items: const [
          Icon(Icons.home_outlined, size: 33, color: Colors.white),
          Icon(Icons.add, size: 33, color: Colors.white),
          Icon(Icons.receipt, size: 33, color: Colors.white),
          Icon(Icons.currency_bitcoin, size: 33, color: Colors.white),
        ],
        color: const Color.fromARGB(255, 79, 78, 78),
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
 Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.blue;
      case 'Transport':
        return Colors.green;
      case 'Entertainment':
        return Colors.red;
      case 'Shopping':
        return const Color.fromARGB(233, 222, 244, 54);
      case 'Health':
        return const Color.fromARGB(255, 54, 244, 241);
      case 'Bills':
        return const Color.fromARGB(255, 244, 54, 187);
      case 'Studies':
        return const Color.fromARGB(255, 139, 54, 244);
      case 'Others':
        return const Color.fromARGB(255, 244, 162, 54);     
      default:
        return const Color.fromARGB(255, 111, 78, 78);
    }}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //print('Today\'s date: $today'); 
       
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Charts
                SingleChildScrollView(
        scrollDirection: Axis.vertical, // Enable vertical scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
              ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance.collection("transactions").get(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text("Error: ${snapshot.error}"));
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text("No transactions available."));
    }

    final now = DateTime.now();
    final currentMonth = DateFormat('yyyy-MM').format(now);

    // Filter transactions for the current month
    final transactions = snapshot.data!.docs.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final date = data['Date'] as String?; // Ensure your Firestore has a 'Date' field
      return date != null && date.startsWith(currentMonth);
    }).toList();

    if (transactions.isEmpty) {
      return const Center(child: Text("No transactions for the current month."));
    }

    double totalIncome = 0;
    Map<String, double> expensesByCategory = {};

    for (var transaction in transactions) {
      final data = transaction.data() as Map<String, dynamic>;
      final category = data['Category'] as String;
      final amount = (data['Amount'] as num).toDouble();
      final type = data['Transaction Type'] as String;

      if (type == 'Income') {
        totalIncome += amount;
      } else if (type == 'Expense') {
        expensesByCategory[category] = (expensesByCategory[category] ?? 0) + amount;
      }
    }

    // Generate pie chart data
    final pieChartData = expensesByCategory.entries.map((entry) {
      final percentage = (entry.value / totalIncome) * 100;
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
      );
    }).toList();

    return SizedBox(
      width: 500,
      height: 300,
      child: PieChart(
        PieChartData(sections: pieChartData),
      ),
    );
  },
),

                    
                  
                    
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
                  
                    //  final balance = totalIncome - totalExpense;
                  
                      return Column(
  children: [
    // Display the total expense and income
    Center(
      child: Text(
        "Total Expense: ₹${totalExpense.toStringAsFixed(2)}\nTotal Income: ₹${totalIncome.toStringAsFixed(2)}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
    ),

    // Add color icons and color names in a row
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the color icons with their labels in the same row
          Column(
            children: [
              Icon(Icons.square, color: Colors.blue, size: 20),
              Text("Food", style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.green, size: 20),
              Text("Transport", style: TextStyle(color: Colors.green)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.red, size: 20),
              Text("Entertainment", style: TextStyle(color: Colors.red)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.yellow, size: 20),
              Text("Shopping", style: TextStyle(color: Colors.yellow)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.cyan, size: 20),
              Text("Health", style: TextStyle(color: Colors.cyan)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.pink, size: 20),
              Text("Bills", style: TextStyle(color: Colors.pink)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.purple, size: 20),
              Text("Studies", style: TextStyle(color: Colors.purple)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Icon(Icons.square, color: Colors.orange, size: 20),
              Text("Others", style: TextStyle(color: Colors.orange)),
            ],
          ),
        ],
      ),
    ),
  ],
);

                     } ),
                     
                     FutureBuilder(
  future: Future.wait([
    FirebaseFirestore.instance.collection("addBudget").get(),
    FirebaseFirestore.instance.collection("transactions").get(),
  ]),
  builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.any((doc) => doc.docs.isEmpty)) {
      return const Center(
        child: Text(
          "No budget or transaction data available",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final addBudgetDocs = snapshot.data![0].docs;
    final transactionsDocs = snapshot.data![1].docs;

    // Prepare data for comparison
    final now = DateTime.now();
    final currentMonth = DateFormat('yyyy-MM').format(now);
    final categoryStatus = <String, Map<String, dynamic>>{};

    // Add budgets to the map
    for (var doc in addBudgetDocs) {
      final data = doc.data() as Map<String, dynamic>;
      final category = data['Category'] ?? 'Unknown';
      final budget = (data['Budget'] as num).toDouble();

      categoryStatus[category] = {
        'budget': budget,
        'totalExpense': 0.0,
      };
    }

    // Add transactions to calculate total expenses per category
    for (var doc in transactionsDocs) {
      final data = doc.data() as Map<String, dynamic>;
      final category = data['Category'] ?? 'Unknown';
      final type = data['Transaction Type'] ?? '';
      final amount = (data['Amount'] as num).toDouble();
      final date = data['Date'] as String?; // Ensure 'Date' field exists and is in correct format

      if (type == 'Expense' && date != null && date.startsWith(currentMonth)) {
        categoryStatus[category] ??= {'budget': 0.0, 'totalExpense': 0.0};
        categoryStatus[category]!['totalExpense'] += amount;
      }
    }

    // Filter categories that exceeded their budget
    final exceededCategories = categoryStatus.entries
        .where((entry) =>
            entry.value['totalExpense'] > entry.value['budget'])
        .toList();

    if (exceededCategories.isEmpty) {
      return const Center(
        child: Text(
          "No categories exceeded their budget this month.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Prepare bar chart data
    final barGroups = exceededCategories.map((entry) {
      final category = entry.key;
      final totalExpense = entry.value['totalExpense'] as double;
      final budget = entry.value['budget'] as double;

      return BarChartGroupData(x: category.hashCode, barRods: [
        BarChartRodData(
          toY: totalExpense,
          color:_getCategoryColor(category), // Set bar color based on category

          width: 15,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          toY: budget,
          color: const Color.fromARGB(223, 191, 190, 190), // Show the budget as a reference
          width: 15,
          borderRadius: BorderRadius.zero,
        ),
      ]);
    }).toList();

    return SizedBox(
      width: 500,
      height: 250,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            
            bottomTitles: AxisTitles(
             // axisNameWidget: const Text('Category'),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final category = exceededCategories
                      .firstWhere((entry) => entry.key.hashCode == value.toInt())
                      .key;
                  return Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) => const FlLine(
              color: Colors.white,
              strokeWidth: 0.5,
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  },
),

                  
                    ],
                  )
            )
          )
                  ),
                ),
                const SizedBox(height: 20),
                // Budget Warnings
               FutureBuilder(
  future: Future.wait([
    FirebaseFirestore.instance.collection("addBudget").get(),
    FirebaseFirestore.instance.collection("transactions").get(),
  ]),
  builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.any((doc) => doc.docs.isEmpty)) {
      return const Center(
        child: Text(
          "No budget or transaction data available",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final addBudgetDocs = snapshot.data![0].docs;
    final transactionsDocs = snapshot.data![1].docs;

    // Get the current month and year
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    // Prepare data for comparison
    final categoryStatus = <String, Map<String, dynamic>>{};

    // Add budgets to the map
    for (var doc in addBudgetDocs) {
      final data = doc.data() as Map<String, dynamic>;
      final category = data['Category'] ?? 'Unknown';
      final budget = data['Budget'] ?? 0;

      categoryStatus[category] = {
        'budget': budget,
        'totalExpense': 0,
        'status': 'Within Budget',
      };
    }

    // Calculate current month's expenses
    for (var doc in transactionsDocs) {
      final data = doc.data() as Map<String, dynamic>;
      final category = data['Category'] ?? 'Unknown';
      final amount = data['Amount'] ?? 0;
      final dateStr = data['Date'] ?? '';

      try {
        final date = DateTime.parse(dateStr);
        if (date.month == currentMonth && date.year == currentYear) {
          if (categoryStatus.containsKey(category)) {
            categoryStatus[category]!['totalExpense'] += amount;
          }
        }
      } catch (e) {
        print("Invalid date format: $dateStr");
      }
    }

    // Determine status
    categoryStatus.forEach((key, value) {
      if (value['totalExpense'] > value['budget']) {
        value['status'] = 'Budget Exceeded';
      }
    });

    // Return the Card with the list of categories
    return Card(
      elevation: 4,
      color: const Color.fromARGB(255, 11, 11, 11),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Budget Warnings (Current Month)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Budget",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Status",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: categoryStatus.keys.length,
                itemBuilder: (context, index) {
                  final category = categoryStatus.keys.elementAt(index);
                  final budget = categoryStatus[category]!['budget'];
                  final status = categoryStatus[category]!['status'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          category,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$$budget",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          status,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  },
),


                const SizedBox(height: 20),
                // Recent Transactions
              // Add this package for date formatting

FutureBuilder(
  future: FirebaseFirestore.instance
      .collection("transactions")
      .where("Date", isEqualTo: today)
      .get(),
  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(
        child: Text(
          "No transactions for today",
          style: TextStyle(color: Colors.white),
        ),
        
      );
    }

    final transactions = snapshot.data!.docs;

    return Card(
      elevation: 4,
      color: const Color.fromARGB(255, 11, 11, 11),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Recent Transactions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Transaction Detail",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Amount",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index].data() as Map<String, dynamic>;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          transaction['Date'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          transaction['Transaction Details'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$${transaction['Amount'] ?? 0}",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  },
),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

