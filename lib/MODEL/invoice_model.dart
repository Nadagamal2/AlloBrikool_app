class InvoiceModel {
  String? code;
  String? status;
  String? message;
  List<Records>? records;

  InvoiceModel({this.code, this.status, this.message, this.records});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  int? id;
  String? savedDate;
  int? totalPrice;
  double? workerPrice;
  String? workerName;
  String? userName;
  String? serviceName;
  double? applicationPrice;
  int? confirmInvoice;
  int? confirmRequestOrderId;
  ConfirmRequestOrder? confirmRequestOrder;

  Records(
      {this.id,
        this.savedDate,
        this.totalPrice,
        this.workerPrice,
        this.workerName,
        this.userName,
        this.serviceName,
        this.applicationPrice,
        this.confirmInvoice,
        this.confirmRequestOrderId,
        this.confirmRequestOrder});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    savedDate = json['savedDate'];
    totalPrice = json['totalPrice'];
    workerPrice = json['workerPrice'];
    workerName = json['workerName'];
    userName = json['userName'];
    serviceName = json['serviceName'];
    applicationPrice = json['applicationPrice'];
    confirmInvoice = json['confirmInvoice'];
    confirmRequestOrderId = json['confirmRequestOrderId'];
    confirmRequestOrder = json['confirmRequestOrder'] != null
        ? new ConfirmRequestOrder.fromJson(json['confirmRequestOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['savedDate'] = this.savedDate;
    data['totalPrice'] = this.totalPrice;
    data['workerPrice'] = this.workerPrice;
    data['workerName'] = this.workerName;
    data['userName'] = this.userName;
    data['serviceName'] = this.serviceName;
    data['applicationPrice'] = this.applicationPrice;
    data['confirmInvoice'] = this.confirmInvoice;
    data['confirmRequestOrderId'] = this.confirmRequestOrderId;
    if (this.confirmRequestOrder != null) {
      data['confirmRequestOrder'] = this.confirmRequestOrder!.toJson();
    }
    return data;
  }
}

class ConfirmRequestOrder {
  int? id;
  int? requestOrderId;
  Null? requestOrder;
  int? isConfirmAccepted;

  ConfirmRequestOrder(
      {this.id,
        this.requestOrderId,
        this.requestOrder,
        this.isConfirmAccepted});

  ConfirmRequestOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestOrderId = json['requestOrderId'];
    requestOrder = json['requestOrder'];
    isConfirmAccepted = json['isConfirmAccepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestOrderId'] = this.requestOrderId;
    data['requestOrder'] = this.requestOrder;
    data['isConfirmAccepted'] = this.isConfirmAccepted;
    return data;
  }
}