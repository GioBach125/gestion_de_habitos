import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitItem extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;

  HabitItem(this.habit, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habit.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(habit.daysCompleted.length, (index) {
          return IconButton(
            icon: Icon(
              habit.daysCompleted[index]
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onPressed: onTap,
          );
        }),
      ),
    );
  }
}
