import 'package:flutter/material.dart';

import '../routes/route_names.dart';

class MenuBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.55,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('UserName'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://img.hubbis.com/optimiser/img/individual/cropped/6637f4b4d0666938ad68075c969ff801f9270f5a.jpg',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(
              context,
              RouteName.dashBoardScreen,
            ),
          ),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text('Attendance'),
            onTap: () => Navigator.pushNamed(
              context,
              RouteName.attendanceScreen,
            ),
          ),
          ListTile(
            leading: Icon(Icons.description_sharp),
            title: Text('Leaves'),
            onTap: () => Navigator.pushNamed(
              context,
              RouteName.leavesScreen,
            ),
          ),
          ListTile(
            leading: Icon(Icons.swipe_outlined),
            title: Text('ODs'),
            onTap: () => Navigator.pushNamed(
              context,
              RouteName.odScreen,
            ),
          ),
          ListTile(
            leading: Icon(Icons.access_time_filled),
            title: Text('Shift'),
            onTap: () => Navigator.pushNamed(
              context,
              RouteName.shiftScreen,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
