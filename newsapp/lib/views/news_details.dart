import 'package:flutter/material.dart';
import 'package:newsapp/common/const.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:provider/provider.dart';

class newsDetails extends StatelessWidget {
  const newsDetails({super.key});

  static String routeName = 'newsPage';

  @override
  Widget build(BuildContext context) {
    final published = ModalRoute.of(context)!.settings.arguments as String;
    final currentData =
        Provider.of<NewsProvider>(context).findByDate(date: published);
    return Scaffold(
      appBar: AppBar(
        title: Text('${currentData.author}'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('${currentData.urlToImage}'))),
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      'News Details',
                      style: myStyle(Colors.black, 22, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${currentData.description}',
                      //  overflow: TextOverflow.visible,
                    ),
                  ],
                )),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text('Content',
                        style: myStyle(Colors.black, 22, FontWeight.bold)),
                    Text(
                      '${currentData.content}',
                      // overflow: TextOverflow.visible,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
