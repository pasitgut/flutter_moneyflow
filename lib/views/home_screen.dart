import 'package:flutter/material.dart';
import 'package:flutter_moneyflow/views/report_screen.dart';
import 'package:flutter_moneyflow/views/settings_screen.dart';
import 'package:flutter_moneyflow/views/subscription_screen.dart';
import 'package:flutter_moneyflow/views/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TransactionScreen(),
    SubscriptionScreen(),
    ReportScreen(),
    SettingsScreen(),
  ];

  void onTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Transaction",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions_rounded),
          label: "Subscription",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.line_axis_rounded),
          label: "Report",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: "Settings",
        ),
      ],
      currentIndex: _currentIndex,
      onTap: onTapped,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    );
  }
}
