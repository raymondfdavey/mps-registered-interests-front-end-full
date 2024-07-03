import 'package:http/http.dart' as http;
import 'dart:convert';
import 'classes.dart';
import "utilities.dart";

// final String baseUrl = "http://localhost:8080/";
final String baseUrl = "https://safe-gorge-81643.herokuapp.com/";
// final String baseUrl = "https://interesting-backend.onrender.com/";
// final String memberDetailsUrlBase =
//     'https://members-api.parliament.uk/api/Members/Search?Name=';


    

Future<List<Member>> fetchMembers() async {
  print("in fetch list");
  String membersRequestUrl = baseUrl + "members";
  // print(membersRequestUrl);
  final response = await http.get(membersRequestUrl,
      headers: {"Content-Type": "application/json; charset=utf-8"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Member> allMembersInListForm =
        convertJsonIntoMemberList(jsonDecode(response.body));
    return allMembersInListForm;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
void registerClick(id) async {
  print("REGISTER CLICK");
  final response = await http.patch(baseUrl + "members/member/$id",
      headers: {"Content-Type": "application/json; charset=utf-8"});
  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    if (responseBody["results"]["result"]["nModified"] == 1) {
      print("CLICKS UPDATED");
    } else {
      print("REPSONSE GOOD BUT CLICKS NOT UPDATED");
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to register click');
  }
}

// Future<Map> fetchMembersDetailsFromParliamentApi(memberName) async {
//   // print("in fetch members details");
//   String nameNoSpace = memberName.replaceAll(' ', '%20');
//   String fullUrlForMemberDetailsRequest = memberDetailsUrlBase + nameNoSpace;
//   print(fullUrlForMemberDetailsRequest);

//   final membersDetailsResponse = await http.get(fullUrlForMemberDetailsRequest,
//       headers: {"Content-Type": "application/json; charset=utf-8"});
//   if (membersDetailsResponse.statusCode == 200) {
//     print("fetched ok");
//     Map responseBodyDecoded = jsonDecode(membersDetailsResponse.body);
//     // print(responseBodyDecoded);
//     try {
//       Map contents = responseBodyDecoded["items"][0];
//       Map detailsExtracted = {};

//       detailsExtracted["parliamentaryId"] = contents["value"]["id"];
//       detailsExtracted["party"] = contents["value"]["latestParty"]["name"];
//       detailsExtracted["constituency"] =
//           contents["value"]["latestHouseMembership"]["membershipFrom"];
//       detailsExtracted["currentMember"] =
//           contents["value"]["latestHouseMembership"]["membershipStatus"] == null
//               ? false
//               : true;
//       if (detailsExtracted["currentMember"] == false) {
//         detailsExtracted["endReason"] =
//             contents["value"]["latestHouseMembership"]["membershipEndReason"];
//       }
//       detailsExtracted["gender"] = contents["value"]["gender"];
//       return detailsExtracted;
//     } catch (e) {
//       print(e);
//     }
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to get member details from parliament API album');
//   }
// }

Future<List<Interest>> fetchInterestsByYear(id, year) async {
  print("IN FETCH BY YEAR $id $year");
  final response = await http.get(baseUrl + "interests/member/$id/year/$year",
      headers: {"Content-Type": "application/json; charset=utf-8"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Interest> interestsByYearToList =
        convertJsonIntoInterestList(jsonDecode(response.body));

    return interestsByYearToList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load MPS register details');
  }
}

Future<List<Interest>> fetchInterestsByCategory(id, category) async {
  if (category ==
      "Land and property portfolio: (i) value over £100,000 and/or (ii) giving rental income of over £10,000 a year") {
    category = "Land";
  }
  print("IN FETCH BY CATEGORY $id $category");
  final response = await http.get(
      baseUrl + "interests/member/$id/category/$category",
      headers: {"Content-Type": "application/json; charset=utf-8"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Interest> interestsByYearToList =
        convertJsonIntoInterestList(jsonDecode(response.body));
    print("BACKIN FETCH");
    return interestsByYearToList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load MPS register details');
  }
}

Future<List<Interest>> fetchAllInterestsById(id) async {
  print("IN FETCH ALL");
  print(id);
  print(baseUrl + "/members/member/$id");
  final response = await http.get(baseUrl + "members/member/$id",
      headers: {"Content-Type": "application/json; charset=utf-8"});

  if (response.statusCode == 200) {
    print('OO HOO');
    List<Interest> allInterestsByIdToList =
        convertJsonIntoInterestList(jsonDecode(response.body));

    return allInterestsByIdToList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load MPS register details');
  }
}

Future<List<Interest>> fetchInterestsByCategoryAndYear(
    id, category, year) async {
  if (category ==
      "Land and property portfolio: (i) value over £100,000 and/or (ii) giving rental income of over £10,000 a year") {
    category = "Land";
  }
  print("IN FETCH BY BOTH $id $category $year");
  final response = await http.get(
      baseUrl + "interests/member/$id/category/$category/year/$year",
      headers: {"Content-Type": "application/json; charset=utf-8"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Interest> interestsByYearToList =
        convertJsonIntoInterestList(jsonDecode(response.body));

    return interestsByYearToList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load MPS register details');
  }
}


//!http://localhost:8080/interests/member/608abfc7133a6b9a5858a0a5/year/2020
// the above is for a member for a certain year
// 
//! http://localhost:8080/interests/member/608abfc7133a6b9a5858a0a5/category/Gifts,%20benefits%20and%20hospitality%20from%20UK%20sources
// the above is for a member and certain category
// 
//! http://localhost:8080/interests/member/608abfc7133a6b9a5858a0a5/category/Gifts,%20benefits%20and%20hospitality%20from%20UK%20sources/year/2019
//the above is for both
