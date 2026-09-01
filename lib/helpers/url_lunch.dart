import 'package:url_launcher/url_launcher.dart';

Future<void> urlLunch(String? url) async {
  if (url == null || url.trim().isEmpty) return;
  final String formattedUrl =
      (url.startsWith('http://') || url.startsWith('https://'))
          ? url.trim()
          : 'https://${url.trim()}';
  final Uri uri = Uri.parse(formattedUrl);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  } catch (e) {
    // Fallback if launch fails
  }
}
