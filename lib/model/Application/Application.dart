class ApplicationModel {
  String appId;
  String fullname;
  String desc;
  String person;
  String contact;
  bool isApproved;
  String postId;
  String effort;

  String breed;
  double long;
  double lat;
  String location;
  String userId;
  String applicantEffort;

  ApplicationModel(
      this.appId,
      this.fullname,
      this.desc,
      this.effort,
      this.person,
      this.contact,
      this.isApproved,
      this.postId,
      this.userId,
      this.long,
      this.lat,
      this.location,
      this.breed,
      this.applicantEffort);
}
