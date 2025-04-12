import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Creditscreen extends StatefulWidget {
  const Creditscreen({super.key});


  @override
  State<Creditscreen> createState() => _CreditscreenState();
}

class _CreditscreenState extends State<Creditscreen> {

  Future<void> launchUrlSiteBrowser({required String url}) async {
    final Uri urlParsed = Uri.parse(url);

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credit"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Create with ❤ by JohnnyGoldSoft ..."),

            SizedBox(height: 10.0),

            ElevatedButton(
              onPressed: () => launchUrlSiteBrowser( url: 'https://github.com/johnnygoldsoft'),
              child: Text('Github ...'),
            ),
          ],
        ),
      ),
    );
  }
}
