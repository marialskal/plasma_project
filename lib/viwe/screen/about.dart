
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({ Key? key,});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'تعذر فتح الرابط: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: const Text(
          'حول التطبيق',
          style: TextStyle(
            color: AppColor.back,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.back),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'معلومات الاتصال',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.back,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.location_on, color: AppColor.back),
                    title: const Text(
                      'ميدان - نُزها – مقابل جامع النُزها، دمشق، سوريا',
                      textAlign: TextAlign.right,
                    ),
                    subtitle: const Text(
                      'العنوان',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),

                  ListTile(
                    onTap: () => _launchURL('tel:0988320091'),
                    leading: const Icon(Icons.phone, color: AppColor.back),
                    title: const Text(
                      '0988 320 091',
                      textAlign: TextAlign.right,
                    ),
                    subtitle: const Text(
                      'الهاتف المحمول',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),

                  ListTile(
                    onTap: () => _launchURL('mailto:plasmaclinic1@gmail.com'),
                    leading: const Icon(Icons.email_outlined, color: AppColor.back),
                    title: const Text(
                      'plasmaclinic1@gmail.com',
                      textAlign: TextAlign.right,
                    ),
                    subtitle: const Text(
                      'البريد الإلكتروني',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),

ListTile(
                    onTap: () => _launchURL('https://www.instagram.com/plasma.clinic2'),
                    leading: const Icon(Icons.camera_alt_outlined, color: AppColor.back),
                    title: const Text(
                      'plasma.clinic2',
                      textAlign: TextAlign.right,
                    ),
                    subtitle: const Text(
                      'Instagram',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}