class Records {
  int? id;
  int? clientOrderId;
  ClientOrder? clientOrder;
  ApplicationUser? workerApplicationUser;
  dynamic isAccepted;
  dynamic requestPrice;

  Records(
      {this.id,
      this.clientOrderId,
      this.clientOrder,
      this.workerApplicationUser,
      this.isAccepted,
      this.requestPrice});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientOrderId = json['clientOrderId'];
    clientOrder = json['clientOrder'] != null
        ? new ClientOrder.fromJson(json['clientOrder'])
        : null;
    workerApplicationUser = json['workerApplicationUser'] != null
        ? new ApplicationUser.fromJson(json['workerApplicationUser'])
        : null;
    isAccepted = json['isAccepted'];
    requestPrice = json['requestPrice'];
  }
}

class ClientOrder {
  int? id;
  String? name;
  String? title;
  String? desc;
  String? photoName;
  Map? applicationUser;

  ClientOrder({
    this.id,
    this.name,
    this.title,
    this.desc,
    this.photoName,
  });

  ClientOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    photoName = json['photoName'];
    applicationUser = json['applicationUser'];
  }
}

class ApplicationUsers {
  String? deviceToken;
  ApplicationUsers({
    this.deviceToken,
  });
  ApplicationUsers.fromJson(Map<String, dynamic> json) {
    deviceToken = json['deviceToken'];
  }
}

class ApplicationUser {
  String? name;
  String? title;
  String? nationalId;
  String? deviceToken;
  String? email;
  String? phoneNumber;

  ApplicationUser({
    this.name,
    this.title,
    this.nationalId,
    this.email,
    this.deviceToken,
    this.phoneNumber,
  });

  ApplicationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    nationalId = json['nationalId'];
    deviceToken = json['deviceToken'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}
