import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Carbon_Chillax/screens/auth/auth_wrapper.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late VideoPlayerController _videoController;
  bool isLastPage = false;

  late AnimationController _textAnimationController;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/landingPage_video.mp4')
      ..initialize().then((_) {
        _videoController.play();
        _videoController.setLooping(true);
        setState(() {});
      });

    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOut));

    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      isLastPage = index == 2;
    });
    _textAnimationController.reset();
    _textAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size?.width ?? 0,
                height: _videoController.value.size?.height ?? 0,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
          // Dark overlay for better text contrast
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Top Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () => _finishOnboarding(),
              child: Text('Skip', style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
            ),
          ),
          // PageView for Onboarding Content
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildPage(
                title: 'Welcome to Carbon Chillex',
                subtitle: 'Your journey to a greener lifestyle starts here.',
                image: 'assets/images/carbon_chillex_logo.png',
              ),
              _buildPage(
                title: 'Track Your Carbon Footprint',
                subtitle: 'Monitor your daily activities and their impact on the environment.',
                 image: 'assets/images/carbon_chillex_logo.png',
              ),
              _buildPage(
                title: 'Live a More Sustainable Life',
                subtitle: 'Get tips and challenges to reduce your carbon emissions.',
                 image: 'assets/images/carbon_chillex_logo.png',
              ),
            ],
          ),
          // Bottom Navigation
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withOpacity(0.5),
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                SizedBox(height: 60), // Adjusted spacing
                isLastPage
                    ? ElevatedButton(
                        onPressed: () => _finishOnboarding(),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600, // Green color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({required String title, required String subtitle, String? image}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (image != null)
        Expanded(
          child: Center(
            child: Image.asset(
              image,
              height: 300, // Adjust height as needed
              errorBuilder: (context, error, stackTrace) {
                // This will catch the error and display a placeholder
                return Icon(Icons.broken_image, size: 100, color: Colors.white.withOpacity(0.7));
              },
            ),
          ),
        ),
        SlideTransition(
          position: _textSlideAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 180), // Space for the bottom navigation
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AuthWrapper()),
    );
  }
}
