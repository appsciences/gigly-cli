//<li id="ember156" class="ember-view   jobs-search-results__list-item occludable-update p0 relative scaffold-layout__list-item" data-occludable-job-id="4004744810">
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

String getNewValue(String html) {

  final document = parser.parse(html);
  const attributeName = 'data-ev-job-uid';
  String returnValue = 'Unknown error';

  Element? firstElement = document.querySelector('article');

  if (firstElement != null) {
    String? currentValue = firstElement.attributes[attributeName];
    if (currentValue != null) {
        returnValue = currentValue;
    } else {
      throw('ERROR: Upwork attribute "$attributeName" not found.');
    }
  } else {
    throw('ERROR: Upwork article attribute "$attributeName" not found.');
  }
  return returnValue;
}
