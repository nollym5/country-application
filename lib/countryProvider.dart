import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryData {
  // String code;
  // int population;
  // String subRegion;
  // double area;
  // String demonym; //people called
  // double gini;
  // String currency;
  // String symbol;
  // String capitalCity;
  // String languages;
  String country;

  CountryData(
      {
        //this.capitalCity,
        // this.subRegion,
        this.country,
        // this.symbol,
        // this.currency,
        // this.demonym,
        // this.population,
        // this.area,
        // this.code,
        // this.gini,
        // this.languages
      });
}

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
      print(_list);

    } else {
      _list=null;
      print(_list);
    }
    return _list;
  }

  List<dynamic> get country => _country;
}
