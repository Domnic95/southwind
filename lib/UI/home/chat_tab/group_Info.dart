import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:southwind/UI/components/loadingWidget.dart';

import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class GroupInfo extends StatefulHookWidget {
  bool? isSingle;
  GroupInfo({this.isSingle = true});

  @override
  _GroupInfoState createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(groupProvider).getGroupMembers();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final __groupProvider = context.read(groupProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: loading
          ? LoadingWidget()
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Stack(
                      children: [
                        Image.asset("assets/images/southwind_logo_single.png"),
                        // Image.network(
                        //   'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
                        //   width: size.width,
                        //   fit: BoxFit.cover,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                              Text(
                                __groupProvider
                                    .listGroup[
                                        __groupProvider.selectedGroupIndex!]
                                    .group!
                                    .groupName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   width: size.width,
                  //   color: primaryColor,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //     child: Text(
                  //       'Domic Lakra',
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  // Divider(
                  //   thickness: 5,
                  //   color: primarySwatch.shade300,
                  //   height: 0,
                  // ),
                  Container(
                    width: size.width,
                    color: primaryColor,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            '${__groupProvider.listOfMembers.length} participates',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: __groupProvider.listOfMembers.length,
                        itemBuilder: (context, index) {
                          return Container(



                            
                            // height: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        __groupProvider
                                            .listOfMembers[index].userProfile!),
                                  ),
                                  // Container(
                                  //   height: 50,
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     child: Image.network(
                                  //         "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        __groupProvider
                                            .listOfMembers[index].fullName!,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: primarySwatch[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
