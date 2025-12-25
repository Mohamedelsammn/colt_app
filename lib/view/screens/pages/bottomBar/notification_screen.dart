import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 150.h(context),
        title: Text(
          "Notification",
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: EmptyWidget(
        img: "assets/img/notification_empty.png",
        message: "No Notification yet",
      ),
    );
  }
}
