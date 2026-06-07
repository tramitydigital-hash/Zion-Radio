import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final String url;

  const SocialButton({
    super.key,
    required this.icon,
    required this.url,
  });

  Future<void> _openUrl() async {
    final uri = Uri.parse(url);

    try {
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        debugPrint("No se pudo abrir: $url");
      }
    } catch (e) {
      debugPrint("URL ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openUrl,
      child: Image.asset(
        icon,
        width: 35,
        height: 35,
        errorBuilder: (_, __, ___) {
          return const Icon(Icons.link, color: Colors.white);
        },
      ),
    );
  }
}