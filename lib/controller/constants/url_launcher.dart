import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static void launchPhone({phone}) =>
      launchUrl(Uri(scheme: 'tel', path: phone));
}
