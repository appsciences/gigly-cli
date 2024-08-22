import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:gigly_cli/linkedin.dart' as linkedin;
import 'package:gigly_cli/upwork.dart' as upwork;

// TODO: Get rid of globals

String linkedinOldValue = 'LinkedIn Unknown error (inital value)';
String upworkOldValue = 'Upwork Unknown error (inital value)';

const upworkUrl =
    'https://www.upwork.com/nx/search/jobs/?nbs=1&q=title%3A%28CTO%29%20OR%20title%3A%28CIO%29%20OR%20title%3A%28Chief%20Technical%29%20OR%20title%3A%28Chief%20Technology%29&sort=recency';
const linkedinUrl =
    'https://www.linkedin.com/jobs/search/?alertAction=viewjobs&currentJobId=4006882797&distance=25&f_TPR=a1724163676-&f_WT=2&geoId=103644278&keywords=%22cto%22%20OR%20%22chief%20technology%22%20OR%20%22chief%20technical%22%20OR%20%22cio%22&origin=JOB_SEARCH_PAGE_JOB_FILTER&sortBy=DD&spellCorrectionEnabled=true';

Future<void> runChecks() async {
  print('\x1B[34m--------------------------------\x1B[0m');
  print('Current date and time: ${DateTime.now()}');

  print('\x1B[32mLINKEDIN:\x1B[0m'); // Start LinkedIn check

  //LinkedIn section
  try {
    linkedinOldValue =
        await runCheck(linkedinUrl, 'LinkdedIn', linkedinOldValue, linkedin.getNewValue);
  } catch (e) {
    print('\x1B[31mLINKEDIN: An error occurred: $e\x1B[0m');
  }

// Upwork section
  print('\x1B[32mUPWORK:\x1B[0m');

  try {
    upworkOldValue = await runCheck(upworkUrl, 'Upwork', upworkOldValue, upwork.getNewValue);
  } catch (e) {
    print('\x1B[31mUPWORK: An error occurred: $e\x1B[0m');
  }
}

  
  Future<String> runCheck(String url, String serviceName, String oldValue, String Function(String) checkFunction) async {
    print('Fetching $serviceName URL $url');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final newValue = checkFunction(response.body);
       print('$serviceName old value: $oldValue');
      print('$serviceName new value: $newValue');

      if (newValue != oldValue) {
       
        print('\x07');
        print('\x07');
        print('\x07');
        print('\x1B[31m$serviceName: CHANGEDETECTED\x1B[0m');

        return newValue;
      } else {
        print('$serviceName: NoChange');
        return oldValue;
      }
    } else {
      throw ('Failed to fetch $serviceName URL $url. Status code: ${response.statusCode}');
    }
  }
  
  

void main() {
  print('Let\'s do this.');

  // TODO: For testing purposes, we will run the fetchArticleAttribute function every 5 minutes
  // Timer.periodic(Duration(minutes: 5), (Timer t) => runChecks());
  Timer.periodic(Duration(seconds: 10), (Timer t) => runChecks());

}
