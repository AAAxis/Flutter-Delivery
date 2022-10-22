import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier
{
  double _totalAmount = 0;

  double get tAmount => _totalAmount;

  displayTotalAmount(number) async
  {
    _totalAmount = number;

    await Future.delayed(const Duration(milliseconds: 10), ()
    {
      notifyListeners();
    });
  }
}