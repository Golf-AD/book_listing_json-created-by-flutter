// @dart=2.9
// above line for disable sound null safety
//importing the Dart package
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import '../../config.dart';
import 'booktile.dart';

/// REST API JSON
///
//Uncomment the line below to run from this file
void main() => runApp(BooksApp());

//Showing book listing in ListView
class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksListing(),
    );
  }
}

//Making HTTP request
//Function to make REST API call
Future<dynamic> makeHttpCall() async {
  //API Key: To be replaced with your key
  final apiKey = "AIzaSyDZVYmsxvZXx6g_MdMIWJyHTyahFM0X-io";
  final apiEndpoint =
      //"https://www.googleapis.com/books/v1/volumes?key=$apiKey&q=python+coding";
      "https://www.googleapis.com/books/v1/volumes?key=$apiKey&q=flutter";
  final http.Response response = await http
      .get(Uri.parse(apiEndpoint), headers: {'Accept': 'application/json'});

  //Parsing API's HttpResponse to JSON format
  //Converting string response body to JSON representation
  final jsonObject = json.decode(response.body);

  //Prints JSON formatted response on console
  print(jsonObject);
  return jsonObject;
}

class BooksListing extends StatefulWidget {
  @override
  _BooksListingState createState() => _BooksListingState();
}

class _BooksListingState extends State<BooksListing> {
  var booksListing;
  fetchBooks() async {
    var response = await makeHttpCall();

    setState(() {
      booksListing = response["items"];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books Listing"),
      ),
      body: ListView.builder(
        itemCount: booksListing == null ? 0 : booksListing.length,
        itemBuilder: (context, index) {
          return BookTile(book: booksListing[index]);
        },
      ),
    );
  }
}
