import 'dart:convert';
import 'package:countries_info/countryProvider.dart';
import 'package:countries_info/routes.dart';
import 'package:countries_info/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:charcode/charcode.dart';
import 'package:provider/provider.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class CountryDetailPage extends StatefulWidget {
  final int argument;

  const CountryDetailPage({Key key, this.argument}) : super(key: key);

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  Future<dynamic> _list;
  List<Widget> items = [];

  Future<dynamic> _fetchCountries() async {
    return await Provider.of<CountryProvider>(context).fetchCountries();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _list = _fetchCountries();
  }

  List<Widget> addCard(BuildContext context, List<dynamic> languages) {
    int start;
    print(languages);
    print('length ${languages.length}');
    for (start = 0; start < languages.length; start++) {
      items.add(
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.blue,
                AppColors.cyan,
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                languages[start]['nativeName'],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                '(${languages[start]['name']})',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.argument;
    dynamic countryData = Provider.of<CountryProvider>(context);
    print(index);
    print(countryData.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _fetchCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String code = snapshot.data[index]['alpha2Code'];
            int population = snapshot.data[index]['population'];
            String subRegion = snapshot.data[index]['subregion'];
            double area = snapshot.data[index]['area'];
            String demonym = snapshot.data[index]['demonym']; //people called
            double gini = snapshot.data[index]['gini'];
            String currency = snapshot.data[index]['currencies'][0]['code'];
            String symbol = snapshot.data[index]['currencies'][0]['symbol'];
            String capitalCity = snapshot.data[index]['capital'];
            List<dynamic> languages;
            languages = snapshot.data[index]['languages'];
            String country = snapshot.data[index]['name'];
            String squared = String.fromCharCodes([$sup2]);
            print(languages);
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Text(
                                      code,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    radius: 30.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        country,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                        subRegion,
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Image.network(
                                'https://flagcdn.com/112x84/${code.toLowerCase()}.png'),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              '$country covers an area of $area  km$squared and has a population of'
                                  ' $population -the nation has a Gini coefficent of $gini. a resident of '
                                  '$country is called a(n) $demonym.The main currency accepted by the legal '
                                  'tender is the $currency which is expressed with th symbol $symbol',
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.location_on_outlined),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sub-Region'),
                              Text(subRegion),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                      indent: 40,
                      endIndent: 0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.location_city),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Capital'),
                              Text(capitalCity),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                      indent: 40,
                      endIndent: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 10, bottom: 10.0),
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              color: AppColors.green),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 0.0,
                              top: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.blur_circular_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                  'Languages',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                            crossAxisCount: 2,
                            children: addCard(context, languages),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0.0,
                                    top: 10.0,
                                    right: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.map_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.05,
                                      ),
                                      Text(
                                        'Bordering Countries',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    color: AppColors.green),
                              ),
                            ],
                          ),
                          Container(
                            height: 140,
                            child: ListView.builder(
                              itemCount: snapshot.data[index]['borders'].length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext builder, int i) {
                                String borderCodeFlag;
                                String borderCode =
                                snapshot.data[index]['borders'][i];

                                for (int y = 0; y < snapshot.data.length; y++) {
                                  if (borderCode ==
                                      snapshot.data[y]['alpha3Code']) {
                                    borderCodeFlag =
                                    snapshot.data[y]['alpha2Code'];
                                  }
                                }
                                return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.network(
                                        'https://flagcdn.com/80x60/${borderCodeFlag.toLowerCase()}.png'),
                                  ),
                                  onTap: () {
                                    for (int y = 0;
                                    y < snapshot.data.length;
                                    y++) {
                                      //pass the current index to next screen
                                      if (borderCodeFlag ==
                                          snapshot.data[y]['alpha2Code']) {
                                        Navigator.pushNamed(
                                            context, AppRoutes.countryDetail,
                                            arguments: y);
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
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
