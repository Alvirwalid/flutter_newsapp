import 'package:flutter/material.dart';
import 'package:newsapp/service/news_api_model.dart';
import 'package:newsapp/views/news_details.dart';

class ArticleWidget extends StatefulWidget {
  Article? articles;

  ArticleWidget({this.articles});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, newsDetails.routeName,
            arguments: widget.articles!.publishedAt);
        setState(() {});
      },
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(children: [
          Container(
            width: 60,
            height: 60,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 60,
              height: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${widget.articles!.urlToImage}',
                    width: size.width * 0.12,
                    height: size.height * 0.12,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${widget.articles!.title}' * 100,
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text('🕒  200'),
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.link)),
                        Text('${widget.articles!.publishedAt}')
                      ],
                    ),
                  )
                ],
              ))
            ]),
          )
        ]),
      ),
    );
  }
}
