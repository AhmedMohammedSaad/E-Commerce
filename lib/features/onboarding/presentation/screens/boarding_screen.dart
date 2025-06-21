import 'package:advanced_app/core/color/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page view with 4 boarding screens
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              BoardingPage(
                image: 'assets/images/onpording.jpg',
                title: '🚀 Order Your System in Minutes!',
                description: '''
Now you can easily, securely, and quickly purchase a ready-made system for your business. 
A system that's ready to run immediately, easy to use, and customizable to your needs. 
All you have to do is choose, and we’ll handle the rest!
''',
                onPressed: () => _nextPage(),
              ),
              BoardingPage(
                image: 'assets/images/onpording3.jpg',
                title: '📱 All Types of Apps in One Place!',
                description:
                    'You can buy any ready-made app, whether it’s a service app or even a complete E-Commerce solution.',
                onPressed: () => _nextPage(),
              ),
              BoardingPage(
                image: 'assets/images/onpording2.jpg',
                title: '🌐 Buy Your Website with Ease',
                description:
                    'Choose from a wide range of ready-made websites across different industries.No hassle, no wasted time – your website is ready to launch instantly.',
                onPressed: () => _nextPage(),
              ),
              BoardingPage(
                image: 'assets/images/onpording4.jpg',
                title: '💡 Like the App? Get Its Source Code!',
                description:
                    'Browse the apps that suit you and purchase their source code with ease. Start editing, improving, and launching your own project – by yourself or with your team!',
                onPressed: () => _navigateToNextScreen(),
                buttonText: 'get_started'.tr(),
              ),
            ],
          ),

          // Page indicator dots
          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 8.h,
                  width: _currentPage == index ? 24.w : 8.w,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),

          // Skip button
          Positioned(
            top: 50.h,
            right: 20.w,
            child: _currentPage < 3
                ? TextButton(
                    onPressed: _navigateToNextScreen,
                    child: Text(
                      'skip'.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacementNamed(context, '/signIn');
  }
}

class BoardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onPressed;
  final String buttonText;

  const BoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onPressed,
    this.buttonText = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(image).animate().fadeIn(duration: 600.ms).slide(begin: const Offset(0.2, 0)),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 200.ms).moveY(begin: 20, end: 0),
                SizedBox(height: 16.h),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                ).animate().fadeIn(delay: 400.ms).moveY(begin: 20, end: 0),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
