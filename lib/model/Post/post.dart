class PostModel {
  final String uid;
  final String location;
  final String breed;
  final String reason;
  final String imgUrl;
  final String contact;
  final String postBy;

  const PostModel( this.uid, this.location, this.breed, this.reason, this.imgUrl, this.contact, this.postBy);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "location": location,
        "breed": breed,
        "reason": reason,
        "imgUrl": imgUrl,
        "contact": contact
  };


}
