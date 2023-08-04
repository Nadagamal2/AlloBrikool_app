class Invoice2Model {
 int? id;
  // String? savedDate;
  // int? totalPrice;
  dynamic workerPrice;
  // String? workerName;
  // String? userName;
  // String? serviceName;
 dynamic applicationPrice;
  // int? confirmInvoice;
  // int? confirmRequestOrderId;
  // ConfirmRequestOrder? confirmRequestOrder;

  Invoice2Model(
      {
        this.id,
        // this.savedDate,
        // this.totalPrice,
        this.workerPrice,
        // this.workerName,
        // this.userName,
        // this.serviceName,
        // this.applicationPrice,
        // this.confirmInvoice,
        // this.confirmRequestOrderId,
        // this.confirmRequestOrder
      });

  Invoice2Model.fromJson(Map<String, dynamic> json) {
     id = json['id'];
    // savedDate = json['savedDate'];
    // totalPrice = json['totalPrice'];
    workerPrice = json['workerPrice'];
    // workerName = json['workerName'];
    // userName = json['userName'];
    // serviceName = json['serviceName'];
    applicationPrice = json['applicationPrice'];
    // confirmInvoice = json['confirmInvoice'];
    // confirmRequestOrderId = json['confirmRequestOrderId'];
    // confirmRequestOrder = json['confirmRequestOrder'] != null
    //     ? new ConfirmRequestOrder.fromJson(json['confirmRequestOrder'])
    //     : null;
  }


}

// class ConfirmRequestOrder {
//   int? id;
//   int? requestOrderId;
//   Null? requestOrder;
//   int? isConfirmAccepted;
//
//   ConfirmRequestOrder(
//       {this.id,
//         this.requestOrderId,
//         this.requestOrder,
//         this.isConfirmAccepted});
//
//   ConfirmRequestOrder.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     requestOrderId = json['requestOrderId'];
//     requestOrder = json['requestOrder'];
//     isConfirmAccepted = json['isConfirmAccepted'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['requestOrderId'] = this.requestOrderId;
//     data['requestOrder'] = this.requestOrder;
//     data['isConfirmAccepted'] = this.isConfirmAccepted;
//     return data;
//   }
// }