class Station {
  String name;
  String? locality;

  Station.fromJson(Map<String, dynamic> data)
      : name = data['Name'],
        locality = data['Locality'];
}
