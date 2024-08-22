//<li id="ember156" class="ember-view   jobs-search-results__list-item occludable-update p0 relative scaffold-layout__list-item" data-occludable-job-id="4004744810">
//<div class="base-card relative w-full hover:no-underline focus:no-underline base-card--link base-search-card base-search-card--link job-search-card job-search-card--active" data-entity-urn="urn:li:jobPosting:4007519330" data-reference-id="T2fz94mPWbHvBP3GBYdR0w==" data-tracking-id="E+lyjUyhhjTqov4YxJNI+g==" data-column="1" data-row="1" aria-current="true">
  
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

String getNewValue(String html) {

  final document = parser.parse(html);

  const attributeName = 'data-entity-urn';
  var returnValue = "LinkedIn unknown error";
  Element? firstElement = document.querySelector('[$attributeName]');

  if (firstElement != null) {
    String? currentValue = firstElement.attributes[attributeName];
    if (currentValue != null) {
        returnValue = currentValue;
    } else {
      throw('ERROR: LinkedInAttribute "$attributeName" not found.');
    }
  } else {
    throw('ERROR: LinkedIn Element with attribute "$attributeName" not found.');
  }
  return returnValue;
}
