import 'package:flutter/material.dart';

class NewsDetailsBody extends StatelessWidget {
  final String author;
  final String title;
  final String description;
  const NewsDetailsBody(
      {super.key,
      required this.author,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/news3.jpg"),
                radius: 20,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        author,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: size.width * 0.04),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cleanText(title),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: size.width * 0.05),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                cleanText(description),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: size.width * 0.045),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String cleanText(String text) {
    return text.replaceAll('_', ' ');
  }
}
//'â', '’'