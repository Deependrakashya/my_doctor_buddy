import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  final String _key = 'onboarding_status';
  Future<void> completeOnboarding() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_key, true);
  }

  Future<bool> isOnboardingCompleted() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_key) ?? false;
  }

  Future<void> removeOnboarding() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(_key);
  }
}
