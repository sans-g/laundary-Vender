import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:laundary_wender_application/appBar.dart';
import './completedOrders.dart';
import 'file:///C:/Users/anmol%20seth/AndroidStudioProjects/laundary_wender_application/lib/userOrders/currentOrders.dart';
import 'file:///C:/Users/anmol%20seth/AndroidStudioProjects/laundary_wender_application/lib/userOrders/deliveredOrders.dart';
import 'package:laundary_wender_application/progressOrders.dart';

class UserOrderPage extends StatefulWidget {
  final String userId;

  UserOrderPage({
    @required this.userId,
  });

  @override
  _UserOrderPageState createState() => _UserOrderPageState();
}

class _UserOrderPageState extends State<UserOrderPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      CurrentOrders(userId: widget.userId),
      ProgressOrders(
        userId: widget.userId,
      ),
      CompletedOrders(
        userId: widget.userId,
      ),
      DeliveredOrders(
        userId: widget.userId,
      ),
    ];
    return Scaffold(
      body: _children[currentIndex],
      appBar: appBar(context, 'Orders'),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(MaterialCommunityIcons.progress_download),
            title: Text('Current'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(MaterialCommunityIcons.progress_alert),
            title: Text('Processing'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(MaterialCommunityIcons.progress_check),
            title: Text(
              'Completed',
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesome5Regular.check_circle),
            title: Text('Delivered'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
