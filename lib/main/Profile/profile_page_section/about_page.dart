import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // For larger screens, we'll use padding to make content narrower.
          double padding = constraints.maxWidth > 600 ? 50.0 : 16.0;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Channel',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to Channel! This app brings you the latest news and information from multiple sources, helping you stay updated and informed.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => dictionaryPage(
                              'https://api.wikimedia.org/wiki/Main_Page'),
                          child: const Text(
                            ' - News Sources: ',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        'We provide news articles from the Currents API and Wikimedia API, offering diverse and up-to-date global perspectives.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    GestureDetector(
                        onTap: () =>
                            dictionaryPage('https://dictionaryapi.dev/'),
                        child: const Text(
                          ' - Free dictionary Api',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                    Text(
                      'Enhance your vocabulary with definitions sourced from the Free Dictionary API. for to know more tap it',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    '- Dependencies: Our app is built using the power of the Flutter framework and relies on several libraries to deliver a seamless and intuitive user experience.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This app respects content licensing. News content from Wikimedia is provided under the Creative Commons Attribution 2.5 License.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        dictionaryPage(
                            'malito:apuuchiha720@gmail.com?subject=Any Query');
                      },
                      child: const Text('contact me for any query'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void dictionaryPage(String url) async {
    // String url = 'https://dictionaryapi.dev/';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'cound not launch $url';
    }
  }
}
