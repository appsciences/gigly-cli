import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:gigly_cli/linkedin.dart' as linkedin;
import 'package:gigly_cli/upwork.dart' as upwork;
import 'dart:io';

// DEBT: Get rid of globals

String linkedinOldValue = 'LinkedIn Unknown error (inital value)';
String upworkOldValue = 'Upwork Unknown error (inital value)';
bool debug = false;

const upworkUrl =
    'https://www.upwork.com/nx/search/jobs/?nbs=1&q=title%3A%28CTO%29%20OR%20title%3A%28CIO%29%20OR%20title%3A%28Chief%20Technical%29%20OR%20title%3A%28Chief%20Technology%29&sort=recency';
const linkedinUrl =
    'https://www.linkedin.com/jobs/search/?alertAction=viewjobs&currentJobId=4006882797&distance=25&f_TPR=a1724163676-&f_WT=2&geoId=103644278&keywords=%22cto%22%20OR%20%22chief%20technology%22%20OR%20%22chief%20technical%22%20OR%20%22cio%22&origin=JOB_SEARCH_PAGE_JOB_FILTER&sortBy=DD&spellCorrectionEnabled=true';

Future<void> runChecks() async {
  if (debug) {
    print('\x1B[34m--------------------------------\x1B[0m');
    print('Current date and time: ${DateTime.now()}');

    print('\x1B[32mLINKEDIN:\x1B[0m'); // Start LinkedIn check
  }

  //LinkedIn section
  try {
    linkedinOldValue = await runCheck(
        linkedinUrl, 'LinkdedIn', linkedinOldValue, linkedin.getNewValue);
  } catch (e) {
    print('${DateTime.now()} \x1B[31mLINKEDIN: An error occurred: $e\x1B[0m');
  }

// Upwork sectio
  if (debug) {
    print('\x1B[32mUPWORK:\x1B[0m');
  }
  try {
    upworkOldValue =
        await runCheck(upworkUrl, 'Upwork', upworkOldValue, upwork.getNewValue);
  } catch (e) {
    print('Current date and time: ${DateTime.now()}');

    print('${DateTime.now()} \x1B[31mUPWORK: An error occurred: $e\x1B[0m');
  }
}

Future<String> runCheck(String url, String serviceName, String oldValue,
    String Function(String) checkFunction) async {
  if (debug) {
    print('Fetching $serviceName URL $url');
  }
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final newValue = checkFunction(response.body);

    if (newValue != oldValue) {
      print('Current date and time: ${DateTime.now()}');

      print('$serviceName old value: $oldValue');
      print('$serviceName new value: $newValue');
      print('\x1B[31m$serviceName: CHANGEDETECTED\x1B[0m');

      print('\x07');
      print('\x07');
      print('\x07');

      return newValue;
    } else {
      if (debug) {
        print('$serviceName: NoChange');
      }
      return oldValue;
    }
  } else {
    throw ('Failed to fetch $serviceName URL $url. Status code: ${response.statusCode}');
  }
}

void main(List<String> arguments) {
  if (arguments.contains('-d')) {
    debug = true;
    print('Debug mode enabled.');
  }

  print('Let\'s do this.');

  if (debug) {
    Timer.periodic(Duration(seconds: 5), (Timer t) => runChecks());
  } else {
    Timer.periodic(Duration(minutes: 5), (Timer t) => runChecks());
  }
}
