import 'package:url_launcher/url_launcher.dart';

class UrlL {
  static Future<void> openUrl(String url) async {
    final parsUrl = Uri.parse(url);
    if (!await launchUrl(parsUrl)) {
      throw 'Could not launch $parsUrl';
    }
  }
}
