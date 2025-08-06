import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weekOffset = 0;

  List<DateTime> generateWeekDates(int weekOffset) {
    final today = DateTime.now();
    final startOfWeek = today
        .subtract(Duration(days: today.weekday - 1))
        .add(Duration(days: weekOffset * 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = generateWeekDates(weekOffset);
    final monthName = DateFormat('MMMM').format(weekDates.first);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => setState(() => weekOffset--),
            ),
            Text(
              monthName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => setState(() => weekOffset++),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weekDates.length,
            itemBuilder: (context, index) {
              final date = weekDates[index];
              final isSelected =
                  DateFormat('yyyy-MM-dd').format(widget.selectedDate) ==
                  DateFormat('yyyy-MM-dd').format(date);
              return GestureDetector(
                onTap: () => widget.onDateSelected(date),
                child: Container(
                  width: 70,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.deepOrangeAccent
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          isSelected
                              ? Colors.deepOrangeAccent
                              : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('d').format(date),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        DateFormat('E').format(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
