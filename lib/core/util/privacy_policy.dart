import 'package:url_launcher/url_launcher.dart';

final class PrivacyPolicy {
  PrivacyPolicy._();

  static Future<void> launchPrivacyPolicy() async {
    final Uri url = Uri.parse(
        'https://www.termsfeed.com/live/0fe24462-d978-4540-978f-3dc9513a2be4');

    try {
      await launchUrl(url);
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error as needed
    }
  }
}
