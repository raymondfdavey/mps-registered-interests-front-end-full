class Member {
  String memberDataId;
  String memberName;
  List yearsOfRecordsHeld;
  List categoriesOfInterestsRegistered;
  int parliamentaryId;
  String party;
  String constituency;
  bool currentMember;
  String reasonForEnding;
  String pictureUrl;
  String gender;
  int clicks;

  @override
  String toString() {
    return 'Member: {memberName: ${this.memberName}, yearsOfRecordsHeld: ${this.yearsOfRecordsHeld}, categoriesOfInterestsRegistered: ${this.categoriesOfInterestsRegistered}, parliamentaryId: ${this.parliamentaryId}, party: ${this.party}, constituency: ${this.constituency}, currentMember: ${this.currentMember}}';
  }
}

class Interest {
  String interestDataId;
  String memberDataId;
  DateTime registerDate;
  String category;
  List interestContent;
  String interestAsString;
}
