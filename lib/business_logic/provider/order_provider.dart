import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/facility.dart';
import 'package:flutter/material.dart';

import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient.dart';

class OrderProvider with ChangeNotifier {
  Patient? patient;
  OrderService orderService;
  OrderProvider({
    this.patient,
    required this.orderService,
  });

  void updatePatient(Patient patientt) {
    patient = patientt;
    notifyListeners();
  }

  void updateOrderService(OrderService orderServicee) async {
    orderService = orderServicee;
    notifyListeners();
  }

  void setServiceType(ServiceType serviceTypee) {
    orderService.serviceType = serviceTypee;
    notifyListeners();
  }

  void setFacility(Facility facilityy) {
    orderService.facility = facilityy;
    notifyListeners();
  }

  void setTotalPay(double totalPayy) {
    orderService.totalPay = totalPayy;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    orderService.paymentMethod = paymentMethod;
    notifyListeners();
  }

  void setOrderDate(DateTime dateTime) {
    orderService.orderDate = dateTime;
    notifyListeners();
  }

  void setPatientRef(String patientRef) {
    orderService.patientRef = patientRef;
    notifyListeners();
  }

  void setOrderStatus(StatusOrder statusOrderr) {
    orderService.statusOrder = statusOrderr;
  }
}
