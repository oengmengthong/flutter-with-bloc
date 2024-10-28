// lib/pages/contributor_detail_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contributor.dart';

class ContributorDetailPage extends StatelessWidget {
  final Contributor contributor;

  const ContributorDetailPage({Key? key, required this.contributor})
      : super(key: key);

  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contributor.login),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Avatar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(contributor.avatarUrl),
              ),
            ),
            // Login
            Text(
              contributor.login,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Contributions
            Text(
              '${contributor.contributions} contributions',
              style: TextStyle(fontSize: 16),
            ),
            // Additional Information
            ListTile(
              leading: Icon(Icons.person),
              title: Text('ID: ${contributor.id}'),
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('GitHub URL'),
              subtitle: Text(contributor.htmlUrl),
              onTap: () => _launchURL(context, contributor.htmlUrl),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Type: ${contributor.type}'),
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title:
                  Text('Site Admin: ${contributor.siteAdmin ? 'Yes' : 'No'}'),
            ),
            // Display any other fields you want
          ],
        ),
      ),
    );
  }
}
