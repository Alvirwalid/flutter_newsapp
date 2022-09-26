import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:newsapp/common/const.dart';
import 'package:newsapp/common/enum.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/service/news_api_model.dart';
import 'package:newsapp/views/search_screen.dart';
import 'package:newsapp/widget/article_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  String sortBy = Newsenum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffF5F5F5),
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          'News app',
          style: myStyle(Colors.black, 18),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SearchScreen(),
                      inheritTheme: true,
                      ctx: context,
                    ));
              },
              icon: Icon(
                IconlyLight.search,
                color: Colors.black,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'All news',
                    style: myStyle(Colors.black, 18, FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (currentIndex > 1) {
                            setState(() {
                              currentIndex = currentIndex - 1;
                            });
                          }
                        },
                        child: Text(
                          'Prev',
                          style: myStyle(Colors.white, 16),
                        )),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = index + 1;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: 35,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: currentIndex == index + 1
                                        ? Colors.blue
                                        : Colors.white),
                                child: Text(
                                  '${index + 1}',
                                  style: myStyle(Colors.black, 12),
                                ),
                              ),
                            );
                          }),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = currentIndex + 1;
                          });
                        },
                        child: Text(
                          'Next',
                          style: myStyle(Colors.white, 16),
                        )),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    value: sortBy,
                    items: [
                      DropdownMenuItem(
                        child: Text('${Newsenum.popularity.name}'),
                        value: Newsenum.popularity.name,
                      ),
                      DropdownMenuItem(
                        child: Text('${Newsenum.publishedAt.name}'),
                        value: Newsenum.publishedAt.name,
                      ),
                      DropdownMenuItem(
                        child: Text('${Newsenum.relevancy.name}'),
                        value: Newsenum.relevancy.name,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        sortBy = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder<List<Article>>(
                    future: newsProvider.getnewsData(
                        page: currentIndex, sortBy: sortBy),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Something is error');
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ArticleWidget(
                              articles: snapshot.data![index],
                            );
                          });
                    })
              ],
            ),
          )),
    );
  }
}
