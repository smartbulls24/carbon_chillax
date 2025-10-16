import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Carbon_Chillax/screens/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildPages() {
    return [
      _buildPage(
        image: 'assets/images/onboarding1.png',
        title: 'Track Your Carbon Footprint',
        description: 'Monitor your daily activities and their impact on the environment.',
      ),
      _buildPage(
        image: 'assets/images/onboarding2.png',
        title: 'Get Eco-Friendly Tips',
        description: 'Receive personalized suggestions to reduce your carbon emissions.',
      ),
      _buildPage(
        image: 'assets/images/onboarding3.png',
        title: 'Join a Green Community',
        description: 'Connect with others who are passionate about saving our planet.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _buildPages(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_buildPages().length, (index) => _buildDot(index, context)),
                ),
                SizedBox(height: 20),
                if (_currentPage == _buildPages().length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text('Get Started'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.green.shade600 : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildPage({required String image, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
