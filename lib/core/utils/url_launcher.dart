import 'package:url_launcher/url_launcher.dart';

Future<void> toggleLaunchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    if (!await launchUrl(url)){
      throw Exception("Could not launch $url");
    }
  } else {
    throw 'Could not launch $url';
  }
}