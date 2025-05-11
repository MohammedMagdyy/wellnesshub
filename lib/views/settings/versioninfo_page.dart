import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class VersionInfoPage extends StatefulWidget {
  const VersionInfoPage({super.key});
  static const routeName = 'VersionInfoPage';

  @override
  State<VersionInfoPage> createState() => _VersionInfoPageState();
}

class _VersionInfoPageState extends State<VersionInfoPage> {
  String appName = '';
  String version = '';
  String buildNumber = '';
  String packageName = '';

  @override
  void initState() {
    super.initState();
    _loadVersionInfo();
  }

  Future<void> _loadVersionInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appName = info.appName;
      version = info.version;
      buildNumber = info.buildNumber;
      packageName = info.packageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'App Info'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(label: 'App Name', value: appName),
            InfoRow(label: 'Package Name', value: packageName),
            InfoRow(label: 'Version', value: version),
            InfoRow(label: 'Build Number', value: buildNumber),
            const SizedBox(height: 20),
            const Text(
              '© 2025 WellnessHub Team\nContact: support@wellnesshub.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
