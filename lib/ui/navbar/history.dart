import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ActivityMonitoringPage extends StatefulWidget {
  @override
  _ActivityMonitoringPageState createState() => _ActivityMonitoringPageState();
}

class _ActivityMonitoringPageState extends State<ActivityMonitoringPage> {
  List<String> activityDetails = [];

  void addActivityDetails(String details) {
    setState(() {
      activityDetails.add(details);
    });
  }

  void deleteAllActivity() {
    setState(() {
      activityDetails.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        deleteAllActivity: deleteAllActivity,
      ),
      body: Column(
        children: [
          // Some widgets related to your activity monitoring display
          // ...

          if (activityDetails.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: activityDetails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(activityDetails[index]),
                  );
                },
              ),
            ),
          250.heightBox,
          if (activityDetails.isEmpty)
            "No activity recorded".text.size(25).makeCentered().p(20),
        ],
      ),
      
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() deleteAllActivity;

  CustomAppBar({
    required this.deleteAllActivity,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: "Activity Observed".text.color(Colors.black).size(24).make(),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    _showDeleteAllConfirmationDialog(context);
                  },
                  child: Text('Delete All Activity'),
                ),
              ),
            ];
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ],
      flexibleSpace: Container(
        height: 144,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 136, 0),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.0))),
      ),
    );
  }

  void _showDeleteAllConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete All Activity'),
          content: Text('Are you sure you want to delete all activity?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteAllActivity(); // Call the deleteAllActivity function
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete All'),
            ),
          ],
        );
      },
    );
  }
}