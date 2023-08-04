class GetConfirmRequestOrderByApplcationUserId {
  int? id;
  int? requestOrderId;
  RequestOrder? requestOrder;
  int? isConfirmAccepted;

  GetConfirmRequestOrderByApplcationUserId(
      {this.id,
      this.requestOrderId,
      this.requestOrder,
      this.isConfirmAccepted});

  GetConfirmRequestOrderByApplcationUserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestOrderId = json['requestOrderId'];
    requestOrder = json['requestOrder'] != null
        ? new RequestOrder.fromJson(json['requestOrder'])
        : null;
    isConfirmAccepted = json['isConfirmAccepted'];
  }
}

class RequestOrder {
  int? id;
  int? clientOrderId;
  ClientOrder? clientOrder;
  WorkerApplicationUser? workerApplicationUser;
  dynamic isAccepted;
  dynamic requestPrice;

  RequestOrder(
      {this.id,
      this.clientOrderId,
      this.clientOrder,
      this.workerApplicationUser,
      this.isAccepted,
      this.requestPrice});

  RequestOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientOrderId = json['clientOrderId'];
    clientOrder = json['clientOrder'] != null
        ? new ClientOrder.fromJson(json['clientOrder'])
        : null;

    workerApplicationUser = json['workerApplicationUser'] != null
        ? new WorkerApplicationUser.fromJson(json['workerApplicationUser'])
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
  String? deviceToken;
  String? nationalId;
  dynamic specialty;
  String? email;
  String? phoneNumber;

  WorkerApplicationUser({
    this.name,
    this.title,
    this.nationalId,
    this.specialty,
    this.email,
    this.deviceToken,
    this.phoneNumber,
  });

  WorkerApplicationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    nationalId = json['nationalId'];
    specialty = json['specialty'];
    deviceToken = json['deviceToken'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}
