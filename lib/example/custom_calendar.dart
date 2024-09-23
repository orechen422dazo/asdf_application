import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime)? onDateSelected;
  final Color selectedColor;
  final Color todayColor;

  const CustomCalendar({
    super.key,
    required this.initialDate,
    this.onDateSelected,
    this.selectedColor = Colors.blue,
    this.todayColor = Colors.red,
  });

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildHeader(),
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _updateMonth(-1),
        ),
        Text(
          DateFormat.yMMMM().format(_currentMonth),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _updateMonth(1),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 7 + _daysInMonth(_currentMonth),
      itemBuilder: (context, index) {
        if (index < 7) return _buildWeekdayName(index);
        return _buildDayButton(index - 7);
      },
    );
  }

  Widget _buildWeekdayName(int index) {
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Center(child: Text(weekdays[index]));
  }

  Widget _buildDayButton(int index) {
    final monthStart = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekday = monthStart.weekday % 7;
    final day = index - firstWeekday + 1;

    if (day < 1 || day > _daysInMonth(_currentMonth)) {
      return Container();
    }

    final date = DateTime(_currentMonth.year, _currentMonth.month, day);
    final isSelected = _isSameDay(date, _selectedDate);
    final isToday = _isSameDay(date, DateTime.now());

    return GestureDetector(
      onTap: () => _selectDate(date),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? widget.selectedColor
              : isToday
                  ? widget.todayColor
                  : null,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              color: isSelected || isToday ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  void _updateMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(date);
    }
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}