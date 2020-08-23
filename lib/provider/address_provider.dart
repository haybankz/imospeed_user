import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/request/address_request.dart';
import 'package:imospeed_user/model/response/address_response.dart';
import 'package:imospeed_user/model/response/addresses_response.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/service/repository/address_repository.dart';

class AddressProvider extends ChangeNotifier{
  AddressRepository _addressRepository = locator<AddressRepository>();

  ApiResponse<AddressesResponse> pickupAddressResponse = ApiResponse<AddressesResponse>.completed(null);
  ApiResponse<AddressesResponse> deliveryAddressResponse = ApiResponse<AddressesResponse>.completed(null);
  ApiResponse<AddressResponse> addressResponse = ApiResponse<AddressResponse>.completed(null);

  ApiResponse<String> updateAddressResponse = ApiResponse<String>.completed(null);
  ApiResponse<String> deleteAddressResponse = ApiResponse<String>.completed(null);

  Future getPickUpAddresses() async {
    pickupAddressResponse = ApiResponse<AddressesResponse>.loading('');
    notifyListeners();

    pickupAddressResponse = await _addressRepository.getPickupAddresses();
    notifyListeners();

  }

  Future getDeliveryAddresses() async {
    deliveryAddressResponse = ApiResponse<AddressesResponse>.loading('');
    notifyListeners();

    deliveryAddressResponse = await _addressRepository.getDeliveryAddresses();
    notifyListeners();

  }

  Future getAddress(AddressType addressType, String addressId) async {
    addressResponse = ApiResponse<AddressResponse>.loading('');
    notifyListeners();

    addressResponse = await _addressRepository.getAddress(addressType, addressId);
    notifyListeners();

  }



  Future<ApiResponse<String>> updateAddress(String addressId, dynamic request) async {
    updateAddressResponse = ApiResponse<String>.loading('');
    notifyListeners();

    updateAddressResponse = await _addressRepository.updateAddress(addressId, request);
    notifyListeners();

    return updateAddressResponse;

  }

  Future<ApiResponse<String>> deleteAddress(AddressType addressType, String addressId) async {
    deleteAddressResponse = ApiResponse<String>.loading('');
    notifyListeners();

    deleteAddressResponse = await _addressRepository.deleteAddress(addressType, addressId);
    notifyListeners();

    return deleteAddressResponse;

  }


}