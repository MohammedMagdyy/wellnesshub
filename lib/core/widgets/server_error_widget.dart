import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class ServerErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const ServerErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                Assets.assetsImagesErrorImg,
                height: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! Server Issues',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Our servers are temporarily unavailable. '
                    'Our team has been notified and is working on a fix.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Try Again'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                   Navigator.pushNamed(context, 'AboutUsPage');
                  },
                  child: const Text('Contact Support'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}