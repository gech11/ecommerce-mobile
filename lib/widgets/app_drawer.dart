import 'package:ecommerce_mobile/screens/auth/login.dart';
import 'package:ecommerce_mobile/screens/auth/register.dart';
import 'package:ecommerce_mobile/screens/home_page.dart';
import 'package:ecommerce_mobile/screens/product/product_create.dart';
import 'package:ecommerce_mobile/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Consumer<Auth>(builder:(context,auth,child){
        return !auth.authenticated ?
        ListView(
          children: [
            ListTile(
              title: Text('create'),
              leading: Icon(Icons.add),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductCreate()))
              },
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()))
              },
            ),
            ListTile(
              title: Text('Login'),
              leading: Icon(Icons.login),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()))
              },
            ),
            ListTile(
              title: Text('Register'),
              leading: Icon(Icons.app_registration),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register()))
              },
            )
          ],
        )
        :ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(height: 10,),
                Text(auth.user!.name,style: TextStyle(color: Colors.white),),
                Text(auth.user!.name,style: TextStyle(color: Colors.white),),
                SizedBox(height: 10,),
              ],
            ),
            decoration:BoxDecoration(
              color: Color(0Xff43db80)
            )
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () => {
              Provider.of<Auth>(context,listen: false).logout()
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()))
            },
          )
        ],
      );
      })
    );
  }
}