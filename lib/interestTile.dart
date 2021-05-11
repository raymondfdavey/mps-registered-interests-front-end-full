import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'utilities.dart';

class InterestTile extends StatefulWidget {
  final interest;
  final year;
  final category;

  InterestTile({Key key, this.interest, this.year, this.category})
      : super(key: key);

  @override
  _InterestTileState createState() => _InterestTileState();
}

class _InterestTileState extends State<InterestTile> {

  List<Widget> listOfTexts(interestsList) {
    List<Widget> listOfTextItems = [];

    interestsList.forEach((e) => {listOfTextItems.add(Text(e))});
    return listOfTextItems;
  }

  @override
  Widget build(BuildContext context) {
    String month =
        convertRegisterDateToMonthString(widget.interest.registerDate);
    // List<Widget> interestContent = listOfTexts(widget.interest.interestContent);



    // if (widget.year == null && widget.category != null)
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white, 
    //       borderRadius: BorderRadius.all(Radius.circular(10))),
    //       padding: EdgeInsets.only(
    //         top: 10, 
    //         bottom: 10
    //         ),
    //       width: MediaQuery.of(context).size.width / 1.3,
    //       child: Column(
    //       children: <Widget>[
    //         Container(
    //           width: MediaQuery.of(context).size.width / 1.3,
    //           child: Text("$month, ${widget.interest.registerDate.year}")),
    //           Container(                
    //             constraints: BoxConstraints(
    //               minHeight: 50, 
    //               maxHeight: 700),
    //             width: MediaQuery.of(context).size.width / 1.3,
    //             child: ListView.separated(
    //               shrinkWrap: true,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Text(widget.interest.interestContent[index]);
    //                 }, 
    //               separatorBuilder: (context, index) => Divider(thickness: 0.5, 
    //               color: Colors.lightBlue, 
    //               indent: MediaQuery.of(context).size.width / 6,
    //               endIndent: MediaQuery.of(context).size.width / 6
    //               ), 
    //               itemCount: widget.interest.interestContent.length)
    //               )
    //               ],
    //               ));



    // else if (widget.year != null && widget.category == null)
      return Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.only(
          top: 10, 
          bottom: 10
          ),
        width: MediaQuery.of(context).size.width / 1.3,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text("$month, ${widget.interest.registerDate.year}", style: TextStyle(fontWeight: FontWeight.bold),)),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text("${widget.interest.category}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)),
            Container(
              constraints: BoxConstraints(
                minHeight: 50, 
                maxHeight: 700
                ),
              width: MediaQuery.of(context).size.width / 1.3,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Text(widget.interest.interestContent[index]);
                  }, 
                  separatorBuilder: (context, index) => Divider(thickness: 0.5, 
                  color: Colors.lightBlue, 
                  indent: MediaQuery.of(context).size.width / 6,
                  endIndent: MediaQuery.of(context).size.width / 6
                  ), 
                  itemCount: widget.interest.interestContent.length),
                  )
                  ],
                  )
                  );
    
    
    
    // else
    // return Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white, 
    //       borderRadius: BorderRadius.all(Radius.circular(10))),
    //     padding: EdgeInsets.only(
    //       top: 10, 
    //       bottom: 10
    //       ),
    //     width: MediaQuery.of(context).size.width / 1.3,
    //     child: Column(
    //       children: <Widget>[
    //         Container(
    //           width: MediaQuery.of(context).size.width / 1.3,
    //           child: Text(month)),
    //           Container(
    //             constraints: BoxConstraints(
    //               minHeight: 50, 
    //               maxHeight: 700),
    //             width: MediaQuery.of(context).size.width / 1.3,
    //             child: ListView.separated(
    //               shrinkWrap: true,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Text(widget.interest.interestContent[index]);
    //                 }, 
    //                 separatorBuilder: (context, index) => Divider(thickness: 0.5, 
    //                 color: Colors.lightBlue, 
    //                 indent: MediaQuery.of(context).size.width / 6,
    //                 endIndent: MediaQuery.of(context).size.width / 6
    //                 ),
    //                 itemCount: widget.interest.interestContent.length)
    //                 )
    //                 ],
    //                 ));
                    }
                    }
