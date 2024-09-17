// drawer_widget.dart
import 'package:flutter/material.dart';
import 'package:datingapp/model/dating_profile_model.dart';
import 'package:datingapp/pages/profile_detailed.dart';
import 'package:datingapp/utils/colors.dart';

class DrawerWidget extends StatelessWidget {
  final VoidCallback onProfileDetailsTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;
  final VoidCallback oncreationTap;

  const DrawerWidget({
    Key? key,
    required this.onProfileDetailsTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
    required this.oncreationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profiles/profile_4.png'),
            ),
          ),
          ListTile(
            title: Text('Profile Details'),
            onTap: onProfileDetailsTap,
          ),
          ListTile(
            title: Text('profile Creation'),
            onTap: oncreationTap,
          ),
          ListTile(
            title: Text('Settings'),
            onTap: onSettingsTap,
          ),
          ListTile(
            title: Text('Logout'),
            onTap: onLogoutTap,
          ),
          
        ],
      ),
    );
  }
}
