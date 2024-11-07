import 'package:flutter/material.dart';

Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete?', style: TextStyle(fontSize: 17)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User does not want to delete
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User wants to delete
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?', style: TextStyle(fontSize: 17)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User does not want to logout
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User wants to logout
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

Future<bool?> showExitConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Are you sure you want to exit the app?', style: TextStyle(fontSize: 17)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User does not want to exit
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User wants to exit
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}


Map<String, double> dataMap = {
  "Pending": 5,
  "In Progress": 3,
  "Closed": 2,
  "Hold": 2,
};



