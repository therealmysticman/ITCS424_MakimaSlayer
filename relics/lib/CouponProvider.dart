import 'package:flutter/material.dart';

class CouponProvider with ChangeNotifier {
  Set<String> _selectedCouponIds = {}; // Set to store selected coupon IDs
  Map<String, dynamic> _selectedCouponData = {}; // Initialize with an empty map
  Set<String> _redeemedCouponIds = {}; // Set to store redeemed coupon IDs

  Set<String> get selectedCouponIds => _selectedCouponIds;

  Map<String, dynamic> get selectedCouponData => _selectedCouponData;

  Set<String> get redeemedCouponIds => _redeemedCouponIds;
  String _selectedCouponTitle = 'Select Coupon'; // Default value

  String get selectedCouponTitle => _selectedCouponTitle; 

  void updateSelectedCouponTitle(String title) {
    _selectedCouponTitle = title;
    notifyListeners();
  }
  
  void selectCoupon(String couponId, Map<String, dynamic> data) {
    _selectedCouponIds.add(couponId);
    _selectedCouponData[couponId] =
        data; // Store data with the corresponding couponId
    notifyListeners();
  }

  void redeemCoupon(String couponId) {
    _redeemedCouponIds.add(couponId);
    notifyListeners();
  }

  void deselectCoupon(String couponId) {
    _selectedCouponIds.remove(couponId);
    _selectedCouponData
        .remove(couponId); // Remove data associated with the coupon
    notifyListeners();
  }

 
void clearRedeemCoupon() {
  _redeemedCouponIds.clear();
  _selectedCouponTitle = 'Select Coupon';
  notifyListeners();
}
 void clearUseRedeemCoupon() {
    // Remove redeemed coupon from selected coupons if present
    _redeemedCouponIds.forEach((couponId) {
      if (_selectedCouponIds.contains(couponId)) {
        _selectedCouponIds.remove(couponId);
        _selectedCouponData.remove(couponId);
      }
    });
    notifyListeners();
  }

  bool isSelected(String couponId) {
    return _selectedCouponIds.contains(couponId);
  }

}
