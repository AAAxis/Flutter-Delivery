class Address
{
  String? name;
  String? phoneNumber;
  String? fullAddress;
  String? city;
  double? lat;
  double? lng;

  Address({
    this.name,
    this.phoneNumber,
    this.city,
    this.fullAddress,
    this.lat,
    this.lng,
  });

  Address.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    fullAddress = json['fullAddress'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['city'] = city;
    data['fullAddress'] = fullAddress;
    data['lat'] = lat;
    data['lng'] = lng;

    return data;
  }
}