import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/delivery.dart';
import 'package:imospeed_user/model/response/deliveries_response.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/delivery_repository.dart';

class DeliveryProvider extends ChangeNotifier{
  DeliveryRepository _deliveryRepository = locator<DeliveryRepository>();

  ApiResponse<DeliveriesResponse> deliveriesResponse = ApiResponse<DeliveriesResponse>.completed(null);

  List<Delivery> pendingDelivery = new List();
  List<Delivery> completedDelivery = new List();


  Future<void> getDeliveries() async {
    deliveriesResponse = ApiResponse<DeliveriesResponse>.loading('');
    pendingDelivery = new List();
    completedDelivery = new List();
    notifyListeners();

    deliveriesResponse = await _deliveryRepository.getDeliveries();
    if(deliveriesResponse.status == Status.COMPLETED){
      for(final delivery in deliveriesResponse.data.deliveries){
        if(['cancelled', 'delivered'].contains(delivery.delivery_status.toLowerCase())){
          completedDelivery.add(delivery);
        }else{
          pendingDelivery.add(delivery);
        }
      }

    }
    notifyListeners();

//    return deliveriesResponse;
  }
}