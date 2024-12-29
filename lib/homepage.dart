import 'package:expense_tracker_1/exp.dart';
import 'package:expense_tracker_1/forms.dart';
import 'package:expense_tracker_1/main.dart';
import 'package:expense_tracker_1/page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'exp.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(
        //  seedColor:const Color.fromARGB(255, 79, 78, 78)
        //),
        useMaterial3: true,
      ),
      home: const HomePageWithNavbar(),
    );
  }
}

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Charts
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 500,
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: Colors.blue,
                              value: 40,
                              title: '40%',
                            ),
                            PieChartSectionData(
                              color: Colors.green,
                              value: 30,
                              title: '30%',
                            ),
                            PieChartSectionData(
                              color: Colors.red,
                              value: 30,
                              title: '30%',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Total Expense: ₹2000\nTotal Income: ₹5000",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 100),
                      child: SizedBox(
                        width: 500,
                        height: 300,
                        child: BarChart(
                          BarChartData(
                            barGroups: [
                              BarChartGroupData(x: 1, barRods: [
                                BarChartRodData(
                                  toY: 10,
                                  color: Colors.blue,
                                  width: 15,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ]), 
                              BarChartGroupData(x: 2, barRods: [
                                BarChartRodData(
                                  toY: 12,
                                  color: Colors.green,
                                  width: 15,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ]),
                              BarChartGroupData(x: 3, barRods: [
                                BarChartRodData(
                                  toY: 15,
                                  color: Colors.red,
                                  width: 15,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ]),
                            ],
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                axisNameWidget: const Text(''),
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                axisNameWidget: const Text(''),
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
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
                                  strokeWidth: 0.5),
                              getDrawingVerticalLine: (value) => const FlLine(
                                  color: Colors.white,
                                  strokeWidth: 0.5),
                            ),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                // Budget Warnings
                Card(
                  elevation: 4,
                  color: const Color.fromARGB(255, 11, 11, 11),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "Budget Warnings",
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Budget",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Category $index",
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "\$${index * 100}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      index % 2 == 0
                                          ? "Exceeded"
                                          : "Within Budget",
                                      style:
                                          const TextStyle(color: Colors.white),
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
                ),
                const SizedBox(height: 20),
                // Recent Transactions
                Card(
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Transaction Detail",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Amount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "2024-12-${index + 1}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Description $index",
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "\$${index * 50}",
                                      style:
                                          const TextStyle(color: Colors.white),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
