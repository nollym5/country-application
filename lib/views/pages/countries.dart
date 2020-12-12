import 'dart:convert';

import 'package:countries_info/countryProvider.dart';
import 'package:countries_info/routes.dart';
import 'package:countries_info/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../routes.dart';
// TODO: fetch list of countries from API and render
// Feel free to change this to a stateful widget if necessary

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  Future<dynamic> _list;

  Future<dynamic> _fetchCountries() async {
    return await Provider.of<CountryProvider>(context).fetchCountries();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _list = _fetchCountries();
  }

  List results = [];
  String query = '';
  List items = [];
  List tempList = [];
  TextEditingController editingController = TextEditingController();

  List<String> listData = List<String>();
  @override
  Widget build(BuildContext context) {
    //final countryData = Provider.of<CountryProvider>(context).fetchCountries();
    return Scaffold(
      appBar: AppBar(
        title: Text("African Countries"),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
        ],
      ),
      body: FutureBuilder(
        future: _fetchCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            items=snapshot.data;

            return Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {

                        setState(() {
                          query = value;
                        });
                        for (int i = 0; i < snapshot.data.length; i++) {

                            if (snapshot.data[i]['name']
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase())) {
                              setState(() {
                                results.add(snapshot.data[i]);
                               // print(results);
                              });
                              print(results);
                            }
                            else{
                              setState(() {
                                results.clear();
                              });

                            }

                      }
                        setState(() {
                          items=results;

                        });
                        },
                      controller: editingController,
                      decoration: InputDecoration(
                          // labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: AppColors.blue,
                            width: 1.0,
                          ))),
                    ),
                    Expanded(
                      child: query.isEmpty
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext builder, int index) {
                                String code =
                                    snapshot.data[index]['alpha2Code'];
                                return GestureDetector(
                                  onTap: () {
                                    //pass the current index to next screen
                                    Navigator.pushNamed(
                                        context, AppRoutes.countryDetail,
                                        arguments: index);
                                  },
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:10.0,left:5.0,right: 5.0 ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Image.network(
                                                  "https://flagcdn.com/w80//${code.toLowerCase()}.png"),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.grey,
                                                ),
                                                padding: EdgeInsets.all(2.0),
                                                child: Text(
                                                  code,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    //backgroundColor: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data[index]
                                                      ['name']),
                                                  Text(snapshot.data[index]
                                                      ['capital'])
                                                ]),
                                          ),
                                          Center(child: Icon(Icons.arrow_forward_ios)),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      height: 20,
                                      thickness: 1,
                                      indent: 100,
                                      endIndent: 0,
                                    ),
                                  ]),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: results.length,
                              itemBuilder: (BuildContext builder, int index) {
                                String code = results[index]['alpha2Code'];
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      leading: Image.network(
                                          'https://flagcdn.com/40x30/${code.toLowerCase()}.png'),
                                      title: Text(results[index]['name']),
                                      subtitle: Text(results[index]['capital']),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      onTap: () {
                                        //pass the current index to next screen
                                        Navigator.pushNamed(
                                            context, AppRoutes.countryDetail,
                                            arguments: index);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.blue,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
