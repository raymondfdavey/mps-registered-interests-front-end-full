import "classes.dart";

String convertRegisterDateToMonthString(DateTime date) {
  Map months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };
  return months[date.month];
}

List<Interest> convertJsonIntoInterestList(Map json) {
  print("IN JSON CONVERSION FUNCTION");
  List jsonList = json["results"];
  List<Interest> listOfInterestEntries = [];
  for (var entry in jsonList) {
    if (entry["category"] == "No records held") {
      continue;
    }
    Interest newInterestEntry = new Interest();
    newInterestEntry.category = entry["category"];
    newInterestEntry.interestContent = entry["interest"];
    newInterestEntry.interestDataId = entry["_id"];
    newInterestEntry.interestAsString = entry["interest"].join();
    newInterestEntry.memberDataId = entry["memberId"];
    newInterestEntry.registerDate = DateTime.parse(entry["registerDate"]);
    listOfInterestEntries.add(newInterestEntry);
  }
  print("DONE CONVERtING");

  final seen = Set();
  final unique = listOfInterestEntries
      .where((element) => seen.add(element.interestAsString))
      .toList();

  return unique;

  // return listOfInterestEntries;

  // List<Member> members = [];
  // print("in conversion");

  // for (var i = 0; i < json["results"].length; i++) {
  //   Map memberJson = json["results"][i];
  //   Member newMember = makeMember(memberJson);
  //   members.add(newMember);
  // }
  // members.sort((a, b) => a.memberName
  //     .split(" ")
  //     .last[0]
  //     .compareTo(b.memberName.split(" ").last[0]));
  // return members;
}


String getLastElement(List<String> list) {
  return list[list.length - 1];
}

List<Member> convertJsonIntoMemberList(Map json) {
  List<Member> members = [];
  print("in conversion");

  for (var i = 0; i < json["results"].length; i++) {
    Map memberJson = json["results"][i];
    Member newMember = makeMember(memberJson);
    members.add(newMember);
  }
  members.sort((a, b) {
      String aLastName = getLastElement(a.memberName.split(' '));
      String bLastName = getLastElement(b.memberName.split(' '));
      return aLastName.compareTo(bLastName);
    });
  return members;
}

Member makeMember(Map member) {
  // print("IN MEMBER CLASS CREATOR");
  Member newMember = new Member();
  newMember.memberDataId = member["_id"];
  newMember.memberName = member["memberName"];
  newMember.yearsOfRecordsHeld = member["yearsOfRecordsHeld"];
  newMember.categoriesOfInterestsRegistered =
      member["categoriesOfInterestsRegistered"];
  newMember.yearsOfRecordsHeld.sort((a, b) => a.compareTo(b));
  newMember.clicks = member["numberOfClicks"];
  return newMember;
}
