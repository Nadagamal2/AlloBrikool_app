class GetRequestOrderByApplcationUserId {
  int? id;
  int? clientOrderId;
  ClientOrder? clientOrder;
  WorkerApplicationUser? workerApplicationUser;
  dynamic isAccepted;
  dynamic requestPrice;
  GetRequestOrderByApplcationUserId(
      {this.id,
      this.clientOrderId,
      this.clientOrder,
      this.workerApplicationUser,
      this.isAccepted,
      this.requestPrice});

  GetRequestOrderByApplcationUserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientOrderId = json['clientOrderId'];
    clientOrder = json['clientOrder'] != null
        ? ClientOrder.fromJson(json['clientOrder'])
        : null;

    workerApplicationUser = json['workerApplicationUser'] != null
        ? WorkerApplicationUser.fromJson(json['workerApplicationUser'])
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
  String? phoneNumber;
  String? photoName;

  ClientOrder({
    this.id,
    this.name,
    this.title,
    this.desc,
    this.phoneNumber,
    this.photoName,
  });

  ClientOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    phoneNumber = json['phoneNumber'];
    photoName = json['photoName'];
  }
}

class WorkerApplicationUser {
  String? name;
  String? title;
  String? nationalId;
  String? email;
  String? phoneNumber;
  WorkerApplicationUser({
    this.name,
    this.title,
    this.nationalId,
    this.email,
    this.phoneNumber,
  });

  WorkerApplicationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    nationalId = json['nationalId'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}
