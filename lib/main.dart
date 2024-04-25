import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BingSearchPage extends StatefulWidget {
  @override
  _BingSearchPageState createState() => _BingSearchPageState();
}

class _BingSearchPageState extends State<BingSearchPage> {
  final String subscriptionKey =  'bc3b952689b5456fa03aa9322f7040cc';
  final String endpoint = "https://api.bing.microsoft.com";

  Future<Map<String, dynamic>> searchBing(String query) async {
    final String apiEndpoint = "$endpoint/v7.0/search";
    final String mkt = "en-US";
    final Map<String, String> params = {'q': query, 'mkt': mkt};
    final Map<String, String> headers = {
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    };

    final Uri uri = Uri.parse(apiEndpoint).replace(queryParameters: params);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bing Search'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            searchBing("Microsoft").then((result) {
              // Handle the API response here
              print(result);
            }).catchError((error) {
              // Handle errors
              print(error.toString());
            });
          },
          child: Text('Search Bing'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Bing Search App',
    home: BingSearchPage(),
  ));
}
