// import 'package:flutter/material.dart';
// import 'package:ksrtcegapp/screens/trip_detail_scree.dart';
// import 'package:ksrtcegapp/screens/start_journey_screen.dart';
// import 'package:ksrtcegapp/screens/attendance_screen.dart';
// import 'package:ksrtcegapp/screens/profile_screen.dart';
// import 'package:ksrtcegapp/screens/widget/drawe_wid.dart';
// import 'package:ksrtcegapp/theme/pallet.dart';

// class DashboardScreen extends StatelessWidget {

//   final String pen;

//   const DashboardScreen({super.key, required this.pen});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(65),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//                Builder(
//                  builder: (context) {
//                    return IconButton(
//                                icon: const Icon(Icons.menu, color: Colors.white, size: 30,), // Drawer icon
//                                onPressed: () => Scaffold.of(context).openDrawer(), // Open Drawer
//                              );
//                  }
//                ),
//           const SizedBox(width: 5,),
//               const CircleAvatar(
//                 radius: 19,
//                 backgroundImage: AssetImage('assets/logo/ktracimage.png')
//               ),
//               const SizedBox(width: 15),
//               Text('Dashboard',
//                   style: Theme.of(context).primaryTextTheme.titleMedium
//                   ),
//             ],
//           ),
//         ),
//       ),
//       drawer: const DrawerScreen(),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 250, 250, 250),
//               Color.fromARGB(255, 203, 203, 188)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 20.0,
//             children: [
//               _buildDashboardCard(
//                 context,
//                 icon: Icons.assignment,
//                 label: 'Trip Details',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => TripDetailsScreen(  pen: pen,)), // tripId: '#38280752'
//                   );
//                 },
//               ),
//               _buildDashboardCard(
//                 context,
//                 icon: Icons.directions_car,
//                 label: 'Start Journey',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StartJourneyScreen()),
//                   );
//                 },
//               ),
//               _buildDashboardCard(
//                 context,
//                 icon: Icons.check_circle,
//                 label: 'Attendance',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AttendanceScreen()),
//                   );
//                 },
//               ),
//               _buildDashboardCard(
//                 context,
//                 icon: Icons.person,
//                 label: 'Profile',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ProfileScreen(pen: pen)),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.0),
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.deepPurple.shade100],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 50.0,
//                 // color: Color.fromARGB(255, 5, 95, 151),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   color: Pallet.blackColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
    
//   }
// }

import 'package:flutter/material.dart';
import 'package:ksrtcegapp/screens/trip_detail_scree.dart';
import 'package:ksrtcegapp/screens/start_journey_screen.dart';
import 'package:ksrtcegapp/screens/attendance_screen.dart';
import 'package:ksrtcegapp/screens/profile_screen.dart';
import 'package:ksrtcegapp/screens/widget/drawe_wid.dart';
import 'package:ksrtcegapp/theme/pallet.dart';

class DashboardScreen extends StatelessWidget {
  final String pen;

  const DashboardScreen({super.key, required this.pen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ), // Drawer icon
                  onPressed: () => Scaffold.of(context).openDrawer(), // Open Drawer
                );
              }),
              const SizedBox(width: 5),
              const CircleAvatar(
                  radius: 19,
                  backgroundImage: AssetImage('assets/logo/ktracimage.png')),
              const SizedBox(width: 15),
              Text('Dashboard',
                  style: Theme.of(context).primaryTextTheme.titleMedium),
            ],
          ),
        ),
      ),
      drawer: const DrawerScreen(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 250, 250),
              Color.fromARGB(255, 203, 203, 188)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 20.0,
                  children: [
                    _buildDashboardCard(
                      context,
                      icon: Icons.assignment,
                      label: 'Trip Details',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TripDetailsScreen(pen: pen)),
                        );
                      },
                    ),
                    _buildDashboardCard(
                      context,
                      icon: Icons.directions_car,
                      label: 'Start Journey',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartJourneyScreen()),
                        );
                      },
                    ),
                    _buildDashboardCard(
                      context,
                      icon: Icons.check_circle,
                      label: 'Attendance',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceScreen()),
                        );
                      },
                    ),
                    _buildDashboardCard(
                      context,
                      icon: Icons.person,
                      label: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(pen: pen)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Spacer and CircleAvatar at the bottom
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/logo/ktracimage.png'),
              // backgroundImage: AssetImage('assets/images/ksrtcimage.jpg'),
            ),
            const SizedBox(height: 10,),
            Text('KTrac Application', style: Theme.of(context).primaryTextTheme.bodyMedium,),
            const SizedBox(height: 60), 
        ],),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.deepPurple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.0,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Pallet.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
