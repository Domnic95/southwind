import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/library_model.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/library/components/library_card.dart';
import 'package:southwind/UI/library/video_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/inputStyle.dart';
import 'package:southwind/data/providers/providers.dart';

class Library extends StatefulHookWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  bool isSearch = false;
  String searchString = '';
  bool searchByText = true;
  List<String> typeList = [
    "All",
    'Trucks',
    "Heath and Safety",
    "Culture",
    "Training - New Hires & Currently employee skill development",
    'Customer Service'
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _libraryNotifier = useProvider(libraryNotifier);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "LIBRARY",
      //     style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
      //   ),
      //   actions: [
      //     Icon(
      //       Icons.menu_outlined,
      //     ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //   ],
      // ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextFormField(
                  onChanged: (v) {
                    if (v.length > 0) {
                      setState(() {
                        isSearch = true;
                        searchString = v;
                        searchByText = true;
                      });
                    } else if (v.length == 0 && isSearch) {
                      setState(() {
                        isSearch = false;
                      });
                    }
                  },
                  decoration: transparentInputDecoration.copyWith(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(maxHeight: 30),
                      filled: true,
                      fillColor: Colors.grey[300]),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: typeList
                                    .map((e) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (e != 'All') {
                                                searchByText = false;
                                                searchString = e;
                                                isSearch = true;
                                              } else {
                                                isSearch = false;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: primaryColor,
                                                        width: 2))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Text(e.toString()),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          });
                    },
                    child: Icon(
                      Icons.filter_list_outlined,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isSearch
                  ? FutureBuilder(
                      future: _libraryNotifier.searchlibraries(
                          searchString, searchByText),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data.length > 0) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return LibraryCard(
                                  libraryModel: snapshot.data[index],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No library resources available',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }
                        } else {
                          return LoadingWidget();
                        }
                      })
                  : FutureBuilder(
                      future: _libraryNotifier.loadLibrayData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (_libraryNotifier.libraries.length > 0) {
                            return ListView.builder(
                              itemCount: _libraryNotifier.libraries.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return LibraryCard(
                                  libraryModel:
                                      _libraryNotifier.libraries[index],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No library resources available',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }
                        } else {
                          return LoadingWidget();
                        }
                      }),
            )
          ],
        ),
      ),
    );
  }
}
