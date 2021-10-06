import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

final _drawerController = ZoomDrawerController();

class MenuItem {
  String title;
  IconData icon;
  MenuItem(this.icon, this.title);
}

final List<MenuItem> options = [
  MenuItem(Icons.payment, 'Payments'),
  MenuItem(Icons.favorite, 'Discounts'),
  MenuItem(Icons.notifications, 'Notification'),
  MenuItem(Icons.format_list_bulleted, 'Orders'),
  MenuItem(Icons.help, 'Help'),
];