import 'package:countries_info/routes.dart';
import 'package:flutter/material.dart';

// TODO: fetch list of countries from API and render
// Feel free to change this to a stateful widget if necessary
class CountriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            '''Fetch and show the list of countries.
Click to navigate to country detail.''',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
