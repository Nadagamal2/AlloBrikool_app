

class clintOrderbServices {
  int? id;
  String? name;
  String? title;
  String? desc;
  String? phoneNumber;
  String? photoName;
  int? serviceId;
  Service? service;
  String? applicationUserId;

  List<ClientOrderPhotos>? clientOrderPhotos;

  clintOrderbServices(
      {this.id,
        this.name,
        this.title,
        this.desc,
        this.phoneNumber,
        this.photoName,
        this.serviceId,
        this.service,
        this.applicationUserId,

        this.clientOrderPhotos});

  clintOrderbServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    phoneNumber = json['phoneNumber'];
    photoName = json['photoName'];
    serviceId = json['serviceId'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    applicationUserId = json['applicationUserId'];

    if (json['clientOrderPhotos'] != null) {
      clientOrderPhotos = <ClientOrderPhotos>[];
      json['clientOrderPhotos'].forEach((v) {
        clientOrderPhotos!.add(new ClientOrderPhotos.fromJson(v));
      });
    }
  }


}

class Service {
  int? id;
  String? name;
  String? photoName;
  String? description;
  List<ClientOrder>? clientOrder;

  Service(
      {this.id, this.name, this.photoName, this.description, this.clientOrder});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photoName = json['photoName'];
    description = json['description'];
    if (json['clientOrder'] != null) {
      clientOrder = <ClientOrder>[];
      json['clientOrder'].forEach((v) {
        clientOrder!.add(new ClientOrder.fromJson(v));
      });
    }
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
  String? applicationUserId;

  List<ClientOrderPhotos>? clientOrderPhotos;

  ClientOrder(
      {this.id,
        this.name,
        this.title,
        this.desc,
        this.phoneNumber,
        this.photoName,
        this.serviceId,
        this.applicationUserId,

        this.clientOrderPhotos});

  ClientOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    phoneNumber = json['phoneNumber'];
    photoName = json['photoName'];
    serviceId = json['serviceId'];
    applicationUserId = json['applicationUserId'];

    if (json['clientOrderPhotos'] != null) {
      clientOrderPhotos = <ClientOrderPhotos>[];
      json['clientOrderPhotos'].forEach((v) {
        clientOrderPhotos!.add(new ClientOrderPhotos.fromJson(v));
      });
    }
  }


}

class ClientOrderPhotos {
  int? id;
  String? imgURL;
  int? clientOrderId;

  ClientOrderPhotos({this.id, this.imgURL, this.clientOrderId});

  ClientOrderPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgURL = json['imgURL'];
    clientOrderId = json['clientOrderId'];
  }


}