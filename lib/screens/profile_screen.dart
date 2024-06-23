import 'package:flutter/material.dart';
import '../database.dart';
import '../models/profile.dart';
import '../widgets/profile_item.dart';
import 'habit_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Profile> _profiles = [];

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final profiles = await DatabaseHelper().getProfiles();
    setState(() {
      _profiles = profiles;
    });
  }

  void _addProfile() {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Perfil'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Nombre del Perfil'),
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
                final profile = Profile(name: _controller.text);
                await DatabaseHelper().insertProfile(profile);
                _loadProfiles();
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProfile(int id) async {
    await DatabaseHelper().deleteProfile(id);
    _loadProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles'),
      ),
      body: ListView.builder(
        itemCount: _profiles.length,
        itemBuilder: (context, index) {
          final profile = _profiles[index];
          return Dismissible(
            key: Key(profile.id.toString()),
            onDismissed: (direction) {
              _deleteProfile(profile.id!);
            },
            child: ProfileItem(profile, () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HabitScreen(profile),
              ));
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProfile,
        child: Icon(Icons.add),
      ),
    );
  }
}
