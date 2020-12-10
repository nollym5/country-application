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
  List items;
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
            //items.add(snapshot.data);
            return Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    TextField(

                      /*   List<String> dummySearchList = List<String>();
                  dummySearchList.addAll(duplicateItems);
                if(query.isNotEmpty) {
              List<String> dummyListData = List<String>();
              dummySearchList.forEach((item) {
                if(item.contains(query)) {
                  dummyListData.add(item);
                }
              });
              setState(() {
                items.clear();
                items.addAll(dummyListData);
              });
              return;
            } else {
            setState(() {
              items.clear();
              items.addAll(duplicateItems);
            });
          }*/
                      onChanged: (value) {
                        query = value;
                        // results.add(snapshot.data);

                        /* for (int i = 0; i <= snapshot.data.length; i++) {

                          if (items[i]['name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase())) {

                            setState(() {
                              results.add(snapshot.data[i]);
                              print(results);
                            });
                          }else{

                          }}*/

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
                            onTap: (){
                              //pass the current index to next screen
                              Navigator.pushNamed(
                                  context, AppRoutes.countryDetail,
                                  arguments: index);
                            },
                            child: Column(

                                children: [Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Image.network(
                                              'https://flagcdn.com/48x36/${code.toLowerCase()}.png'),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
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
                                      SizedBox(width:MediaQuery.of(context).size.width*0.07 ,),
                                      Expanded(
                                        flex:2,
                                        child: Column(
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text(snapshot.data[index]['name']),
                                              Text(snapshot.data[index]['capital'])

                                            ]),
                                      ),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 20,
                                    thickness: 1,
                                    indent: 70,
                                    endIndent: 0,
                                  ),
                                ]),
                          );
                        },
                      )
                          : ListView.builder(
                        itemCount: results == null ? 0 : results.length,
                        itemBuilder: (BuildContext builder, int index) {
                          String code =
                          results[index]['alpha2Code'];
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
