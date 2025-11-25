class OnboardingModel {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

// Onboarding data based on reference images
final List<OnboardingModel> onboardingPages = [
  const OnboardingModel(
    title: 'Welcome to 3M Code Store',
    subtitle: 'Discover thousands of products at your fingertips',
    imagePath: 'assets/onboarding/onboarding_1.png',
  ),
  const OnboardingModel(
    title: 'Easy & Secure Shopping',
    subtitle: 'Shop with confidence and enjoy a seamless experience',
    imagePath: 'assets/onboarding/onboarding_2.png',
  ),
  const OnboardingModel(
    title: 'Fast Delivery',
    subtitle: 'Get your orders delivered quickly to your doorstep',
    imagePath: 'assets/onboarding/onboarding_3.png',
  ),
];
