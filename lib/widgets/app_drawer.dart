import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(height: 10,),
                Text('John Doe'),
                Text('johndoe@gmail.com'),
                SizedBox(height: 10,),
              ],
            ),
            decoration:BoxDecoration(
              color: Color(0Xff43db80)
            )
          ),
          ListTile(
            title: Text('login'),
            leading: Icon(Icons.login),
            onTap: () => {

            },
          ),
          ListTile(
            title: Text('logout'),
            leading: Icon(Icons.logout),
            onTap: () => {
              
            },
          )
        ],
      )
    );
  }
}