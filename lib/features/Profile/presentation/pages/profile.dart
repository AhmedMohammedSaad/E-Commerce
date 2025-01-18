// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getDataUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is GetDataUserFailure) {
            log(state.error);
          }
          if (state is GetDataUserSuccess) {
            log("succsses");
          }
        },
        builder: (context, state) {
          final user = context.read<ProfileCubit>().getDataUserModel;

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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text(
                        user?.name ?? 'UserName',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Email
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text(
                        textAlign: TextAlign.center,
                        user?.email ?? 'YourEmail@Gmail.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                      onTap: () async {
                        // Logout
                        final supabase = Supabase.instance.client;

                        await supabase.auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/signIn',
                          (route) => false,
                        );
                      },
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
        },
      ),
    );
  }
}
