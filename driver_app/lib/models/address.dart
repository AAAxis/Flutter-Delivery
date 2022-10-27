class Address
{
  String? name;
  String? phoneNumber;
  String? fullAddress;
  String? city;

  Address({
    this.name,
    this.phoneNumber,
    this.city,
    this.fullAddress,
  });

  Address.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    fullAddress = json['fullAddress'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['city'] = city;
    data['fullAddress'] = fullAddress;
    return data;
  }
}