

class clintOrderbySpecialty {
  int? id;
  String? name;
  String? title;
  String? desc;
  String? phoneNumber;
  String? photoName;
  int? serviceId;

  String? applicationUserId;
  ApplicationUser? applicationUser;

  clintOrderbySpecialty(
      {this.id,
        this.name,
        this.title,
        this.desc,
        this.phoneNumber,
        this.photoName,
        this.serviceId,

        this.applicationUserId,
        this.applicationUser});

  clintOrderbySpecialty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    phoneNumber = json['phoneNumber'];
    photoName = json['photoName'];
    serviceId = json['serviceId'];

    applicationUserId = json['applicationUserId'];
    applicationUser = json['applicationUser'] != null
        ? new ApplicationUser.fromJson(json['applicationUser'])
        : null;
  }


}

class ApplicationUser {
  String? name;
  String? title;
  String? nationalId;
  String? specialty;

  String? email;

  String? phoneNumber;


  ApplicationUser(
      {this.name,
        this.title,
        this.nationalId,
        this.specialty,

        this.email,

        this.phoneNumber,
  });

  ApplicationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    nationalId = json['nationalId'];
    specialty = json['specialty'];

    email = json['email'];

    phoneNumber = json['phoneNumber'];

  }


}