import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:async';

String oldValue  = 'Getting started';

Future<void> fetchArticleAttribute(String url, String attributeName, String lastValue) async {

  String? attributeValue = '';
  try {
    // Fetch the HTML content of the URL
    final response = await http.get(Uri.parse(url));
    
    print('-------------------------------------');
    print('Fetched URL, response: ${response.statusCode}');
  
    // Print current date and time
    print('Current date and time: ${DateTime.now()}');

    if (response.statusCode == 200) {
      // Parse the HTML content
      var document = parse(response.body);

      // Find the first <article> element
      Element? articleElement = document.querySelector('article');

      if (articleElement != null) {
        // Get the value of the specified attribute
        attributeValue = articleElement.attributes[attributeName];

        if (attributeValue != null) {
          print('Current value of the "$attributeName" attribute is: $attributeValue');
          print('Old value: $lastValue');
          if (attributeValue != lastValue) {
            print('Value changed!');
            print('\x07');
            print('\x07');
            print('\x07');
            oldValue = attributeValue;// Global variable

          } else {
            print('Value has not changed.');
          }
        } else {
          print('Attribute "$attributeName" not found in the first <article> element.');
        }
      } else {
        print('No <article> element found in the HTML content.');
      }
    } else {
      print('Failed to load the URL. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  
}

void main() {
  // Example usage
  String url = 'https://www.upwork.com/nx/search/jobs/?nbs=1&q=title%3A%28CTO%29%20OR%20title%3A%28CIO%29%20OR%20title%3A%28Chief%20Technical%29%20OR%20title%3A%28Chief%20Technology%29&sort=recency';
  String attributeName = 'data-ev-job-uid';

  print('Let\'s do this.');

// Run fetchArticleAttribute every 5 minutes
  Timer.periodic(Duration(minutes: 5), (Timer t) => fetchArticleAttribute(url, attributeName, oldValue));
  // fetchArticleAttribute(url, attributeName);
}
