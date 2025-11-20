import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadBanner extends StatelessWidget {
  const DownloadBanner({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey[200],
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16.0,
        runSpacing: 8.0,
        children: [
          Text(
            'Juga tersedia di platform lain:',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.android, size: 18),
            label: const Text('Download .apk (Android)'),
            onPressed: () {
              _launchURL('https://mindspace.asia/downloads/mindspace.apk');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3DDC84),
              foregroundColor: Colors.white,
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.window, size: 18),
            label: const Text('Download .exe (Windows)'),
            onPressed: () {
              _launchURL('https://mindspace.asia/downloads/mindspace_installer.exe');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0078D6),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}