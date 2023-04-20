import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quote_app/helper/quotehelper.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  Future<List<Map<String, dynamic>>>? data;
  int Id = 0;
  int m = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    get_id();
  }

  getdata() async {
    quoteHelper.quote_helper.InsertData();
    data = quoteHelper.quote_helper.SelectAll(mood: "happy");
  }

  get_id() async {
    print("Komal");
    await Future.delayed(
      Duration(seconds: 10),
      () {
        setState(() {
          if(Id<m) {
            Id++;
            print(Id);
          }
          else
            {
              Id = 0;
            }
        });
      },
    );


    get_id();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              data = quoteHelper.quote_helper.SelectAll(mood: "happy");
              Id =0;
              setState(() {});
            },
            child: Text(
              "Happy",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              data = quoteHelper.quote_helper.SelectAll(mood: "Sad");
              Id = 0;
              setState(() {});
            },
            child: Text(
              "Sad",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
      body: StatefulBuilder(builder: (context, setStata) {
        return FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>>? data = snapshot.data;
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text("${Id + 1}"),
                      title: Text("${data![Id]['Content']}"),
                      subtitle: Text("${data[Id]['mood']}"),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }),
    );
  }
}
