import 'package:flutter/material.dart';
import '../database.dart';
import '../models/habit.dart';
import '../models/profile.dart';
import '../widgets/habit_item.dart';

class HabitScreen extends StatefulWidget {
  final Profile profile;

  HabitScreen(this.profile);

  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  List<Habit> _habits = [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habits = await DatabaseHelper().getHabits(widget.profile.id!);
    setState(() {
      _habits = habits;
    });
  }

  void _addHabit() {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Hábito'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Nombre del Hábito'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final habit = Habit(
                  name: _controller.text,
                  daysCompleted: List.generate(7, (_) => false),
                  profileId: widget.profile.id!,
                );
                await DatabaseHelper().insertHabit(habit);
                _loadHabits();
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteHabit(int id) async {
    await DatabaseHelper().deleteHabit(id);
    _loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hábitos de ${widget.profile.name}'),
      ),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return Dismissible(
            key: Key(habit.id.toString()),
            onDismissed: (direction) {
              _deleteHabit(habit.id!);
            },
            child: HabitItem(habit, () {
              setState(() {
                habit.daysCompleted[DateTime.now().weekday - 1] =
                    !habit.daysCompleted[DateTime.now().weekday - 1];
                DatabaseHelper().updateHabit(habit);
              });
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        child: Icon(Icons.add),
      ),
    );
  }
}
