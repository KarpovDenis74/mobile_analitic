import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'dart:io' as io;
import 'package:analitic/common/fetch_http_analitic.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class HomeScreenRSS extends StatefulWidget {
  const HomeScreenRSS({super.key});
  @override
  HomeScreenRSSState createState() => HomeScreenRSSState();
}

class HomeScreenRSSState extends State {
  bool _darkTheme = false;
  List _habsList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _darkTheme ? ThemeData.light() : ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Найди товар'),
                actions: [Icon(_getAppBarIcon()), _getPlatformSwitch()]),
            body: FutureBuilder(
              future: _getHttpHabs(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  print(' Пока не нашли данные');

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print(' Нашли данные');
                  return Container(
                      child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                        bottom: 20.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _habsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Text(
                                '${_habsList[index].title}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                '${parseDescription(
                                    _habsList[index].description)}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(DateFormat('dd.mm.yyyy kk:mm').format(
                                      DateTime.parse(
                                          '${_habsList[index].pubDate}'))),
                                  FloatingActionButton.extended(
                                    onPressed: null,
                                    label: Text('Читать'),
                                    icon: Icon(Icons.arrow_forward),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ));
                }
                ;
              },
            )));
  }

  _getAppBarIcon() {
    if (_darkTheme) {
      return Icons.highlight;
    } else {
      return Icons.lightbulb;
    }
  }

  _getPlatformSwitch() {
    if (io.Platform.isIOS) {
      return CupertinoSwitch(
        value: _darkTheme,
        onChanged: (bool value) {
          setState(() {
            _darkTheme = !_darkTheme;
          });
        },
      );
    } else if (io.Platform.isAndroid) {
      return Switch(
        value: _darkTheme,
        onChanged: (bool value) {
          setState(() {
            _darkTheme = !_darkTheme;
          });
        },
      );
    }
  }

  _getHttpHabs() async {
    var uri = Uri(scheme: 'https', host: 'habr.com', path: '/ru/rss/articles/');
    var response = await fetchHttpAnalitic(uri);
    var chanel = RssFeed.parse(response.body);
    chanel.items!.forEach((element) {
      _habsList.add(element);
    });
    return _habsList;
  }
}
