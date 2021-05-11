import 'package:flutter/material.dart';
import "network.dart";
import "classes.dart";
import 'spinner.dart';
import 'memberPage.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Member> allMembersSummary;
  List<Member> membersUntouched;
  int highestClicks;
  bool gotMembers = false;
  bool search = false;
  FocusNode myFocusNode;
  bool clickMap = false;

  @override
  void initState() {
    getListOfMembers();
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: search ? Icon(Icons.cancel) : Icon(Icons.search),
            onPressed: () {
              search ? searchForAnMp('') : print("THIS");
              toggleSearch();
            }),
        title: Text("MP's Registered Interests"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'about',
              //  'clickMap'
               }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          myFocusNode.unfocus();
        },
        child: Container(
            color: Colors.grey[180],
            constraints: BoxConstraints.expand(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  search
                      ? TextField(
                          cursorColor: Colors.black,
                          autofocus: true,
                          focusNode: myFocusNode,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: 'Find an MP...',
                          ),
                          onTap: () => myFocusNode.requestFocus(),
                          onChanged: (text) => {
                            searchForAnMp(text),
                          },
                        )
                      : Container(),

                  gotMembers
                      ? Expanded(
                          child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: ListView.builder(
                            itemCount: allMembersSummary.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.2,
                                        color: const Color(0xFFF5F5F5)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                    child: Builder(
                                        builder: (context) => TextButton(
                                            child: Text(
                                              allMembersSummary[index]
                                                  .memberName,
                                              style: TextStyle(
                                                  fontSize: clickMap
                                                      ? 16 +
                                                          (10.57467 +
                                                              (-0.06772519 -
                                                                      10.57467) /
                                                                  (1 +
                                                                      pow(
                                                                          (allMembersSummary[index].clicks /
                                                                              1994.536),
                                                                          0.7219245)))
                                                      : 16),
                                            ),
                                            onPressed: () {
                                              print("clicking");
                                              incrementClick(
                                                  allMembersSummary[index]
                                                      .memberDataId);
                                              navigateToMemberPage(context,
                                                  allMembersSummary[index]);
                                            }))),
                              );
                            },
                            // separatorBuilder: (context, index) => Divider(thickness: 0.1, color: Colors.grey[180]),
                          ),
                        ))
                      : Spinner()
                  // : Image.asset("gate.jpg", scale: 0.5, ),
                ])),
      ),
    );
  }

  void incrementClick(id) async {
    print("incrementing clicks");
    print(id);
    registerClick(id);
  }

  void getListOfMembers() async {
    List<Member> listOfAllMembersFromApi = await fetchMembers();
    returnedMembers(listOfAllMembersFromApi);
  }

  void returnedMembers(members) {
    print("setting state");
    List<Member> copyOfMembers = [...members];
    copyOfMembers.sort((a, b) => a.clicks.compareTo(b.clicks));

    setState(() {
      allMembersSummary = members;
      membersUntouched = members;
      highestClicks = copyOfMembers.last.clicks;
      gotMembers = true;
    });
  }

  void navigateToMemberPage(context, member) {
    print("in about");
    print(member.memberName);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(member.memberName),
              ),
              body: Container(
                  color: Colors.grey[180], child: MemberPage(member: member))));
      // body: Text("HI")));
    }));
  }

  void searchForAnMp(searchTerm) {
    print("searching");
    print(searchTerm);
    if (searchTerm == '') {
      setState(() {
        allMembersSummary = membersUntouched;
      });
    } else {
      List<Member> filteredMembers = membersUntouched
          .where((member) => member.memberName
              .toLowerCase()
              .contains(searchTerm.toLowerCase()))
          .toList();
      setState(() {
        allMembersSummary = filteredMembers;
      });
    }
  }

  void toggleSearch() {
    print("TOGGELING SEARCH");
    setState(() {
      search = !search;
    });
  }

  void handleClick(String value) {
    print(value);
    switch (value) {
      case 'about':
        break;
      case 'clickMap':
        setState(() {
          clickMap = !clickMap;
        });
        break;
    }
  }
}
