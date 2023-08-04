

class ConfirmModel {
  int? id;
  int? requestOrderId;
  RequestOrder? requestOrder;
  int? isConfirmAccepted;

  ConfirmModel(
      {this.id,
        this.requestOrderId,
        this.requestOrder,
        this.isConfirmAccepted});

  ConfirmModel.fromJson(Map<String, dynamic> json) {
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
  String? workerApplicationUserId;
  WorkerApplicationUser? workerApplicationUser;
 dynamic isAccepted;
dynamic requestPrice;

  RequestOrder(
      {this.id,
        this.clientOrderId,
        this.clientOrder,
        this.workerApplicationUserId,
        this.workerApplicationUser,
        this.isAccepted,
        this.requestPrice});

  RequestOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientOrderId = json['clientOrderId'];
    clientOrder = json['clientOrder'] != null
        ? new ClientOrder.fromJson(json['clientOrder'])
        : null;
    workerApplicationUserId = json['workerApplicationUserId'];
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
  int? serviceId;
  // Null? service;
  String? applicationUserId;
  // Null? applicationUser;

  ClientOrder(
      {this.id,
        this.name,
        this.title,
        this.desc,
        this.phoneNumber,
        this.photoName,
        this.serviceId,
        // this.service,
        this.applicationUserId,
        // this.applicationUser
      });

  ClientOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    phoneNumber = json['phoneNumber'];
    photoName = json['photoName'];
    serviceId = json['serviceId'];
    // service = json['service'];
    applicationUserId = json['applicationUserId'];
    // applicationUser = json['applicationUser'];
  }


}

class WorkerApplicationUser {
  String? name;
  String? title;
  String? nationalId;

  String? id;
  String? userName;

  String? email;


  String? phoneNumber;


  WorkerApplicationUser(
      {this.name,
        this.title,
        this.nationalId,

        this.id,
        this.userName,

        this.email,

        this.phoneNumber,

      });

  WorkerApplicationUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    nationalId = json['nationalId'];

    id = json['id'];
    userName = json['userName'];
     email = json['email'];

    phoneNumber = json['phoneNumber'];

  }


}