// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leding: false,
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/profileimage.png',
                ),
              ),
              SizedBox(height: 10),
              // User Name
              Text(
                'Ahmed Saad',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              // Email
              Text(
                'ahmedSaad@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              // Navigation Options
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Order History'),
                onTap: () {
                  // Navigate to Order History Page
                },
              ),

              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Payment Methods'),
                onTap: () {
                  // Navigate to Payment Methods Page
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Shipping Addresses'),
                onTap: () {
                  // Navigate to Shipping Addresses Page
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {
                  // Navigate to Notifications Settings
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help Center'),
                onTap: () {
                  // Navigate to Help Center
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Navigate to Settings
                },
              ),
              SizedBox(height: 20),
              // Logout Button
              BottonAPP(
                nameBotton: 'Logout',
                colorBotton: ColorManager.red,
                colorText: ColorManager.white,
                width: double.infinity,
              )
                  .animate()
                  // .fadeIn(duration: 600.ms)
                  .then(delay: 200.ms)
                  .slide(
                    begin: const Offset(0.1, 1.0), // Start from the right
                    end: Offset.zero, // End at the original position
                    duration: 200.ms,
                  ),
            ],
          )
              .animate()
              // .fadeIn(duration: 600.ms)
              .then(delay: 200.ms)
              .slide(
                begin: const Offset(0.1, 1.0), // Start from the right
                end: Offset.zero, // End at the original position
                duration: 200.ms,
              ),
        ),
      ),
    );
  }
}
