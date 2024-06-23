import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileItem extends StatelessWidget {
  final Profile profile;
  final VoidCallback onTap;

  ProfileItem(this.profile, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(profile.name),
      onTap: onTap,
    );
  }
}
