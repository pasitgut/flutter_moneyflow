import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Map<String, dynamic>> _settingsList = [
    {"title": 'Account', "icon": Icons.account_balance_rounded},
    {"title": 'Category', "icon": Icons.category_rounded},
    {"title": 'Backup & Restore', "icon": Icons.backup_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(child: _buildSettingList()),
      ),
    );
  }

  Widget _buildSettingList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _settingsList.length,
      itemBuilder: (context, index) {
        var item = _settingsList[index];
        return ListTile(
          onTap: () => debugPrint("Go to ${item['title']} screen"),
          leading: Container(
            decoration: BoxDecoration(),
            child: Icon(item['icon'], color: Color(0xFF303030)),
          ),
          title: Text(item['title']),
        );
      },
    );
  }
}
