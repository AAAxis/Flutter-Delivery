import 'package:url_launcher/url_launcher.dart';

class MapsUtils
{
  MapsUtils._();



  //text address
  static Future<void> openMapWithAddress(String fullAddress) async
  {
    String query = Uri.encodeComponent(fullAddress);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if(await launch(googleMapUrl))
    {
      await launch(googleMapUrl);
    }
    else
    {
      throw "Could not open the map.";
    }
  }
}