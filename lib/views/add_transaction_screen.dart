import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String amount = "128.00";
  String description = "Enter description";
  DateTime selectedDate = DateTime.now();
  String category = "Food";
  IconData categoryIcon = Icons.fastfood;
  String transactionType = '';

  final GlobalKey _categoryButtonKey = GlobalKey();

  final GlobalKey _transactionTypeButtonKey = GlobalKey();

  void _showCategoryMenu(BuildContext context) {
    final RenderBox button =
        _categoryButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      color: Color(0xFFFAFAFA),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Food',
          child: Row(
            children: [Icon(Icons.fastfood), SizedBox(width: 10), Text('Food')],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Transportation',
          child: Row(
            children: [
              Icon(Icons.directions_car),
              SizedBox(width: 10),
              Text('Transportation'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Shopping',
          child: Row(
            children: [
              Icon(Icons.shopping_bag),
              SizedBox(width: 10),
              Text('Shopping'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Bills',
          child: Row(
            children: [Icon(Icons.receipt), SizedBox(width: 10), Text('Bills')],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Entertainment',
          child: Row(
            children: [
              Icon(Icons.movie),
              SizedBox(width: 10),
              Text('Entertainment'),
            ],
          ),
        ),
      ],
    ).then((String? value) {
      if (value != null) {
        setState(() {
          category = value;

          switch (value) {
            case 'Food':
              categoryIcon = Icons.fastfood;
              break;
            case 'Transportation':
              categoryIcon = Icons.directions_car;
              break;
            case 'Shopping':
              categoryIcon = Icons.shopping_bag;
              break;
            case 'Bills':
              categoryIcon = Icons.receipt;
              break;
            case 'Entertainment':
              categoryIcon = Icons.movie;
              break;
            default:
              categoryIcon = Icons.fastfood;
          }
        });
      }
    });
  }

  void _showDateTimePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    ).then((date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
        ).then((time) {
          if (time != null) {
            setState(() {
              selectedDate = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            });
          }
        });
      }
    });
  }

  void _showTransactionType(BuildContext context) {
    final RenderBox button =
        _transactionTypeButtonKey.currentContext!.findRenderObject()
            as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      color: Color(0xFFFAFAFA),
      items: [
        PopupMenuItem(child: Text("Expense")),
        PopupMenuItem(child: Text("Income")),
        PopupMenuItem(child: Text("Transfer")),
      ],
    ).then((String? value) {
      if (value != null) {
        setState(() {
          transactionType = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Add Transaction",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            key: _transactionTypeButtonKey,
            onPressed: () {
              _showTransactionType(context);
            },
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text("Income"))),
                    Expanded(child: Center(child: Text("Expense"))),
                    Expanded(child: Center(child: Text("Transfer"))),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    amount.contains(".")
                                        ? "\$${amount.split('.')[0]}"
                                        : "\$$amount",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF121212),
                                ),
                              ),
                              TextSpan(
                                text:
                                    amount.contains(".")
                                        ? ".${amount.split('.')[1]}"
                                        : '',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          key: _categoryButtonKey,
                          onTap: () {
                            _showCategoryMenu(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFFFAFAFA),
                                  width: 6.0,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(categoryIcon, size: 20),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    category,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Add this
                                    maxLines:
                                        1, // Add this to ensure it doesn't overflow
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () {
                            _showDateTimePicker(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_month, size: 20),
                              const SizedBox(width: 5),
                              Center(
                                child: Text(
                                  DateFormat(
                                    'dd MMM yyyy - HH:mm',
                                  ).format(selectedDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  children: [
                    _buildNumberButton("1"),
                    _buildNumberButton("2"),
                    _buildNumberButton("3"),
                    _buildNumberButton("4"),
                    _buildNumberButton("5"),
                    _buildNumberButton("6"),
                    _buildNumberButton("7"),
                    _buildNumberButton("8"),
                    _buildNumberButton("9"),
                    _buildNumberButton("."),
                    _buildNumberButton("0"),
                    _buildDeleteButton(),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add transaction logic
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.1),
                        ),
                        backgroundColor: Color(0xFF121212),
                        overlayColor: Colors.black,
                        fixedSize: Size(double.infinity, 56),
                        // padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "Add Transaction",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        setState(() {
          if (amount == "0.00" || amount == "0.0") {
            if (number == ".") {
              amount = "0.";
            } else {
              amount = number;
            }
          } else {
            if (number == "." && amount.contains(".")) {
              return;
            }
            amount += number;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFFAFAFA), width: 3),
          borderRadius: BorderRadius.circular(0.1),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onLongPress: () {
        setState(() {
          amount = "0.00";
        });
      },
      onTap: () {
        // Handle delete
        setState(() {
          if (amount.isNotEmpty) {
            amount = amount.substring(0, amount.length - 1);
            if (amount.isEmpty || amount == "0.") {
              amount = "0.00";
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFFAFAFA), width: 3),
          borderRadius: BorderRadius.circular(0.1),
        ),
        child: const Center(child: Icon(Icons.backspace_outlined, size: 28)),
      ),
    );
  }
}
