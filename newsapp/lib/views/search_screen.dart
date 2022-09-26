import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:newsapp/common/const.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/widget/article_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();

  late final FocusNode focusNode;
  bool isSearch = false;

  List searchType = [
    'Football',
    'Meta',
    'Apple',
    'Alvi',
    'Ultra',
    'Flutter',
    'Badminton',
    'Android'
  ];

  @override
  void initState() {
    // TODO: implement initState
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (mounted) {
      searchcontroller.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<NewsProvider>(context, listen: false);
    var searchResult = searchProvider.searchList;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          focusNode.unfocus();
                          Navigator.pop(context);
                        },
                        child: Icon(
                          IconlyLight.arrowLeft2,
                          size: 30,
                        ),
                      ),
                      Flexible(
                          child: TextField(
                        focusNode: focusNode,
                        autofocus: true,
                        controller: searchcontroller,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onEditingComplete: () async {
                          await searchProvider.getDataBySearch(
                              search: searchcontroller.text);
                          isSearch = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 8 / 5, left: 5),
                            hintText: 'Search',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffix: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  focusNode.unfocus();
                                  searchcontroller.clear();
                                  searchResult = [];
                                  isSearch = false;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                ),
                              ),
                            )),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      searchProvider.getDataBySearch(
                          search: searchcontroller.text);
                    },
                    child: Text(
                      'Search',
                      style: myStyle(Colors.white, 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 90,
                    child: GridView.builder(
                      itemCount: searchType.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 2.5),
                      itemBuilder: ((context, index) => GestureDetector(
                            onTap: () {
                              searchcontroller.text = searchType[index];
                              searchProvider.getDataBySearch(
                                  search: searchType[index]);
                              setState(() {});
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(8),
                              child: Center(
                                  child: Text(
                                '${searchType[index]}',
                                style: myStyle(Colors.white, 16),
                              )),
                            ),
                          )),
                      shrinkWrap: true,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return ArticleWidget(
                          articles: searchResult[index],
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
