import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryProvider with ChangeNotifier {
  List<dynamic> _list;
  var countryDetails;
  List<dynamic> _country;
  Future<dynamic> fetchCountries() async {
    http.Response response =
    await http.get("https://restcountries.eu/rest/v2/region/africa");

    if (response.statusCode == 200) {
      _list = jsonDecode(response.body);
      _country=_list;


    } else {
      _list=null;

    }
    return _list;
  }


}
