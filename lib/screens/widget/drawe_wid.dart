import 'package:flutter/material.dart';
import 'package:ksrtcegapp/screens/login_screen.dart';
import 'package:ksrtcegapp/theme/pallet.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

 void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you really want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                _logout(context); 
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
   void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return 
    Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             Column(
               children: [
                 DrawerHeader(
                  decoration: BoxDecoration(color: Pallet.redColor),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/logo/ktracimage.png'),
                    ),
                  )
             )],
             ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: ListTile(
                leading:  const Icon(Icons.logout, color: Pallet.blackColor,),
                title:   Text('Logout',style: Theme.of(context).primaryTextTheme.bodyMedium ),
                onTap: () => _showLogoutDialog(context), 
              ),
            ),
          ],
        ),
      );
    
    
  }
}