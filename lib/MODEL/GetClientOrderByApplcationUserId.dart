

class GetClientOrderByApplcationUserId {
  int? id;
  String? name;
  String? title;
  String? desc;
  String? phoneNumber;
  String? photoName;


  GetClientOrderByApplcationUserId(
      {this.id,
        this.name,
        this.title,
        this.desc,
        this.phoneNumber,
        this.photoName,
      });

  GetClientOrderByApplcationUserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    phoneNumber = json['phoneNumber'];
    photoName = json['photoName'];

  }


}