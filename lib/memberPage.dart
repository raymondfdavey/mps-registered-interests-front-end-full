import 'package:flutter/material.dart';
import 'classes.dart';
import 'spinner.dart';
import "network.dart";
import 'interestTile.dart';

class MemberPage extends StatefulWidget {
  final Member member;
  MemberPage({this.member});
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  String selectedYear;
  String selectedCategory;
  bool gotData;
  List<Interest> selectedInterests;

  void getInterests(year, category) async {
    setState(() {
      gotData = false;
    });
    String memberIdOnDatabase = widget.member.memberDataId;
    if (year == null && category == null) {
      print("GETTING ALLLLL INTERST FOR A PERSON");
      List<Interest> interests = await fetchAllInterestsById(memberIdOnDatabase);

     setState(() {
        print("SETTING STATE");
        selectedInterests = new List.from(new Set.from(interests));
        gotData = true;
      });
    } else if (year == null) {
      print("catergory NULL");
      print("YEAR = $year");
      print("CATEGORY = $category");
      List<Interest> interests =
          await fetchInterestsByCategory(memberIdOnDatabase, category);

      print("BEFORE SET STATE");
      setState(() {
        print("SETTING STATE");
        selectedInterests = new List.from(new Set.from(interests));
        gotData = true;
      });
      print("SETTED STATE");
    } else if (category == null) {
      print("YEAR IS NULL");
      print("YEAR = $year");
      print("CATEGORY = $category");
      List<Interest> interests =
          await fetchInterestsByYear(memberIdOnDatabase, year);

      setState(() {
        selectedInterests = new List.from(new Set.from(interests));
        gotData = true;
      });
      print("SETTED STATE");
    } else if (year != null && category != null) {
      print("BOTH IN PLAY");
      print("YEAR = $year");
      print("CATEGORY = $category");
      List<Interest> interests = await fetchInterestsByCategoryAndYear(
          memberIdOnDatabase, category, year);

      setState(() {
        selectedInterests = new List.from(new Set.from(interests));
        gotData = true;
      });
      print("SETTED STATE");
    }
  }

  @override
  void initState() {
    getInterests(selectedYear, selectedCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedYear);
    Member finalMember = widget.member;
    print("BUILDIN");
    print("GT DATA =  $gotData");

    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(children: <Widget>[
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border(
                      bottom: BorderSide(color: Colors.blueGrey, width: 1.5))),
              width: MediaQuery.of(context).size.width,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Select a Year"),
                      value: selectedYear,
                      onChanged: (String newYearSelection) {
                        setState(() {
                          selectedYear = newYearSelection;
                        });
                        getInterests(newYearSelection, selectedCategory);
                      },
                      items: finalMember.yearsOfRecordsHeld.map((year) {
                        return DropdownMenuItem<String>(
                            value: year, child: Text(year));
                      }).toList(),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 450),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text("Select a Category"),
                        value: selectedCategory,
                        onChanged: (String newSelectedCategory) {
                          setState(() {
                            selectedCategory = newSelectedCategory;
                          });
                          getInterests(selectedYear, newSelectedCategory);
                        },
                        items: finalMember.categoriesOfInterestsRegistered
                            .map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child:
                                Text(category, overflow: TextOverflow.visible),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border(
                      bottom: BorderSide(color: Colors.blueGrey, width: 1.5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Select a Year"),
                      value: selectedYear,
                      onChanged: (String newYearSelection) {
                        setState(() {
                          selectedYear = newYearSelection;
                        });
                        getInterests(newYearSelection, selectedCategory);
                      },
                      items: finalMember.yearsOfRecordsHeld.map((year) {
                        return DropdownMenuItem<String>(
                            value: year, child: Text(year));
                      }).toList(),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 450),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text("Select a Category"),
                        value: selectedCategory,
                        onChanged: (String newSelectedCategory) {
                          setState(() {
                            selectedCategory = newSelectedCategory;
                          });
                          getInterests(selectedYear, newSelectedCategory);
                        },
                        items: finalMember.categoriesOfInterestsRegistered
                            .map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child:
                                Text(category, overflow: TextOverflow.visible),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
        gotData != true
            ? Expanded(
                child: Column(children: <Widget>[
                Container(child: Expanded(child: Spinner())),
              ]))
            : Expanded(
                    // child: Container(
                    //         decoration: BoxDecoration(color: Colors.green,border: Border.all(color:Colors.green, width: 1.5)),
                    child: ListView.separated(
                        itemCount: selectedInterests.length,
                        itemBuilder: (context, index) {
                          return Container(
                              color: Colors.grey[180],
                              padding: new EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              // decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color:Colors.brown, width: 1.5), borderRadius: BorderRadius.all(Radius.circular(50)),
                              //  ),
                              child: InterestTile(
                                  interest: selectedInterests[index],
                                  year: selectedYear,
                                  category: selectedCategory));
                        },
                        separatorBuilder: (context, index) => Divider(
                              height: 2,
                              color: Colors.white,
                              indent: 15,
                              endIndent: 15,
                            )))
  

                // ? MembersInterestsComponent(
                //     selectedInterests: selectedInterests,
                //     selectedYear: selectedYear,
                //     selectedCategory: selectedCategory)
    //             : Container(
    //                 child: Expanded(
    //                     child: Image.asset(
    //                 "gate.jpg",
    //                 scale: 0.6,
    //               ))),
      ]),
    );
  }
}
// }

//     return gotDetails
//         ? Column(children: <Widget>[
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //   children: <Widget>[
//             //     finalMember.party == null ? Text(finalMember.party) : Text("uknown"),
//             //     finalMember.constituency == null ? Text(finalMember.constituency) : Text("uknown"),
//             //     finalMember.currentMember == null ? Text("Current MP: ${finalMember.currentMember}") : Text("uknown"),
//             //   ],
//             // ),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 DropdownButton<String>(
//                   hint: Text("Select a Year"),
//                   value: selectedYear,
//                   onChanged: (String newYearSelection) {
//                     setState(() {
//                       selectedYear = newYearSelection;
//                     });
//                   },
//                   items: finalMember.yearsOfRecordsHeld.map((year) {
//                     return DropdownMenuItem<String>(
//                         value: year, child: Text(year));
//                   }).toList(),
//                 ),
//                 DropdownButton<String>(
//                   hint: Text("Select a Category"),
//                   value: selectedCategory,
//                   onChanged: (String newSelectedCategory) {
//                     setState(() {
//                       selectedYear = newSelectedCategory;
//                     });
//                   },
//                   items: finalMember.categoriesOfInterestsRegistered
//                       .map((category) {
//                     return DropdownMenuItem<String>(
//                         value: category, child: Text(category));
//                   }).toList(),
//                 ),
//               ],
//             )
//           ])
//         : Spinner();
//   }
// }
