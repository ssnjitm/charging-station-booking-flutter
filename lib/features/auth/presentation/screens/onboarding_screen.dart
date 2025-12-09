import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/theme.dart';
import '../../../../shared/components/components.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      icon: Icons.flash_on,
      title: 'Fast Charging',
      description: 'Charge your EV in minutes with our high-speed charging stations across Nepal',
      color: AppTheme.primaryColor,
    ),
    OnboardingPage(
      icon: Icons.location_on,
      title: 'Find Stations Easily',
      description: 'Discover nearby charging stations in real-time with live availability updates',
      color: AppTheme.secondaryColor,
    ),
    OnboardingPage(
      icon: Icons.payment,
      title: 'Easy Payment',
      description: 'Pay securely with eSewa, Khalti, or your digital wallet',
      color: AppTheme.accentColor,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return OnboardingPageView(page: pages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.xl),
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: AppTheme.textSecondary.withValues(alpha: 0.3),
                    activeDotColor: AppTheme.primaryColor,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: SecondaryButton(
                          label: 'Back',
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    if (_currentPage > 0) const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: _currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                        onPressed: () {
                          if (_currentPage == pages.length - 1) {
                            context.go('/login');
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
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

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageView({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: page.color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            page.icon,
            size: 60,
            color: page.color,
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.lg),
          child: Column(
            children: [
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
