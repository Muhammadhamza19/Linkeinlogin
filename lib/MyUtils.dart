// // import 'package:decibel_career_portal/Support/Export/MyExport.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:logger/logger.dart';
// import 'dart:developer' as developer;

// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// class MyUtils {
//   static String dateTimeDisplayFormat = "EEE d MMM,yyyy hh:mm aa";

//   static Future<String> getPrefs(String key) async {
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences prefs = await _prefs;
//     return (prefs.getString(key) ?? "");
//   }

//   static Future<bool> setPrefs(String key, String value) async {
//     late Future<bool> _status;

//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences prefs = await _prefs;

//     _status = prefs.setString(key, value).then((bool success) {
//       return _status;
//     });

//     return false;
//   }

//   static Future<bool> isLogin() async {
//     String _result = await getPrefs(PREF_KEY_USER_LOGIN_ID);

//     if (_result.isEmpty) {
//       return false;
//     }

//     return true;
//   }

//   static Future<String> deviceType() async {
//     if (!kIsWeb && Platform.isAndroid) {
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       return 'Android: ${androidInfo.model}';
//     } else if (!kIsWeb && Platform.isIOS) {
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       return 'iPhone: ${iosInfo.utsname.machine}';
//     } else {
//       return "Web";
//     }
//   }

//   static Future<GenericRequest> getGenericRequest(
//       GenericRequest request) async {
//     final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
//     // Box<UserVM> userVM = UserVM.getItem();

//     // if (userVM.length > 0) {
//     //   request.employeeIndex = userVM.get(0)!.loginID!;

//     // }

//     // var empIndex;
//     // empIndex =
//     //     await secureStorage.read(key: '${dotenv.env['EMPLOYEE_INDEX']!}');

//     request.employeeIndex =
//         "300000001"; //empIndex; //"300000089"; //300000001 //2 //300000033
//     request.ipAddress = "";
//     request.languageCode = "";
//     request.deviceID = ""; //(await PlatformDeviceId.getDeviceId)!;
//     request.deviceType = ""; //(await deviceType());
//     request.fcmToken = ""; //(await getPrefs(PREF_KEY_FCM));
//     request.apnsToken = '';
//     request.signature = ""; //(await generateSignature(request));

//     return request;
//   }

//   static Future<String> generateSignature(GenericRequest request) async {
//     String sequence1 = request.employeeIndex +
//         request.languageCode +
//         request.deviceType +
//         request.deviceID +
//         request.deviceDetail +
//         request.ipAddress +
//         request.fcmToken +
//         request.apnsToken;
//     String sequence2 = request.parameter_1! +
//         request.parameter_2! +
//         request.parameter_3! +
//         request.parameter_4! +
//         request.parameter_5! +
//         request.parameter_6! +
//         request.parameter_7! +
//         request.parameter_8! +
//         request.parameter_9! +
//         request.parameter_10! +
//         request.parameter_11! +
//         request.parameter_12! +
//         request.parameter_13! +
//         request.parameter_14! +
//         request.parameter_15! +
//         request.parameter_16! +
//         request.parameter_17! +
//         request.parameter_18!;

//     String sequence3 = sequence1 + sequence2 + dotenv.env['APP_SALT']!;

//     return md5.convert(utf8.encode(sequence3)).toString();
//   }

//   // static showSnackBar(BuildContext context, String text) {
//   //   final snackBar = SnackBar(content: Text(text));
//   //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   // }

//   static showSnackBarInfo(BuildContext context, String text) {
//     showTopSnackBar(
//       context,
//       CustomSnackBar.info(
//         message: text,
//       ),
//     );
//   }

//   static showSnackBarSuccess(BuildContext context, String text) {
//     showTopSnackBar(
//       context,
//       CustomSnackBar.success(
//         message: text,
//       ),
//     );
//   }

//   static showSnackBarError(BuildContext context, String text) {
//     showTopSnackBar(
//       context,
//       CustomSnackBar.error(
//         message: text,
//       ),
//     );
//   }

//   static showloader(BuildContext context) {
//     try {
//       EasyLoading.show(
//         status: (MyLanguage.of(context)?.translateFromFile('loading'))!,
//         maskType: EasyLoadingMaskType.custom,
//       );
//     } catch (e) {}
//   }

//   static hideloader() {
//     try {
//       EasyLoading.dismiss();
//     } catch (e) {}
//   }

//   static printMe(String text) {
//     if (dotenv.env['IS_LOG_ON'] == "true") {
//       // var logger = Logger(
//       //   printer: PrettyPrinter(
//       //       methodCount: 2, // number of method calls to be displayed
//       //       errorMethodCount: 8, // number of method calls if stacktrace is provided
//       //       lineLength: 10000, // width of the output
//       //       colors: true, // Colorful log messages
//       //       printEmojis: true, // Print an emoji for each log message
//       //       printTime: false // Should each log print contain a timestamp
//       //   ),
//       // );
//       // logger.d(text);

//       //debugPrint('Decibel Log : $text');

//       print(text);
//     }
//   }

//   static String displayDateTimeFromDevice() {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat(dateTimeDisplayFormat).format(now);
//     return formattedDate.toString();
//   }

//   static Future<String> loginToFirebase() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: '${dotenv.env['Firebase_LOGIN_EMAIL']!}',
//               password: '${dotenv.env['Firebase_LOGIN_PASSWORD']!}');

//       //FirebaseDatabase.instance.setLoggingEnabled(false);

//       printMe('mu_uuid_${userCredential.user!.uid}');

//       return userCredential.user!.uid;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         printMe('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         printMe('Wrong password provided for that user.');
//       }
//     }

//     return "";
//   }

//   static routeTo(BuildContext context, Widget screen, String name) {
//     pushNewScreenWithRouteSettings(
//       context,
//       settings: RouteSettings(name: name),
//       screen: screen,
//       withNavBar: true,
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//     );
//   }

//   static routeToModal(BuildContext context, Widget screen) {
//     showCupertinoModalBottomSheet(
//       expand: true,
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) => screen,
//     );
//   }

//   static bool isValidDate(String fromDate, String toDate) {
//     DateTime dt1 = DateTime.parse("$fromDate 12:00:00");
//     DateTime dt2 = DateTime.parse("$toDate 12:00:00");

//     if (dt1.compareTo(dt2) == 0) {
//       print("Both date time are at same moment.");

//       return false;
//     }

//     if (dt1.compareTo(dt2) < 0) {
//       print("DT1 is before DT2");

//       return true;
//     }

//     if (dt1.compareTo(dt2) > 0) {
//       print("DT1 is after DT2");

//       return false;
//     }
//     return false;
//   }

//   static String formateDateForDateTimeSelector(String mmddyyyy) {
//     try {
//       if (mmddyyyy.contains(",")) {
//         String split_mmddyyyy_into_mmdd = mmddyyyy.split(",")[0];
//         String split_mmddyyyy_into_yyyy = mmddyyyy.split(",")[1];
//         String split_mmdd_into_mm =
//             _convertMonthNameToOrdinal(split_mmddyyyy_into_mmdd.split(" ")[0]);
//         String split_mmdd_into_dd = split_mmddyyyy_into_mmdd.split(" ")[1];

//         MyUtils.printMe(
//             "converted_dates_${split_mmddyyyy_into_yyyy.trim()}-${split_mmdd_into_mm.trim()}-${split_mmdd_into_dd.trim()}");

//         return "${split_mmddyyyy_into_yyyy.trim()}-${split_mmdd_into_mm.trim()}-${split_mmdd_into_dd.trim()}";
//       }
//     } catch (e) {}

//     return mmddyyyy;
//   }

//   static String _convertMonthNameToOrdinal(String monthName) {
//     switch (monthName) {
//       case 'Jan':
//         {
//           return '01';
//         }

//       case 'Feb':
//         {
//           return '02';
//         }

//       case 'Mar':
//         {
//           return '03';
//         }

//       case 'Apr':
//         {
//           return '04';
//         }

//       case 'May':
//         {
//           return '05';
//         }

//       case 'Jun':
//         {
//           return '06';
//         }

//       case 'Jul':
//         {
//           return '07';
//         }

//       case 'Aug':
//         {
//           return '08';
//         }

//       case 'Sep':
//         {
//           return '09';
//         }

//       case 'Oct':
//         {
//           return '10';
//         }

//       case 'Nov':
//         {
//           return '11';
//         }

//       case 'Dec':
//         {
//           return '12';
//         }
//     }

//     return monthName;
//   }

//   static RichText richText(String no1, String no2) {
//     return RichText(
//       text: TextSpan(
//         children: <TextSpan>[
//           TextSpan(
//               text: no1,
//               style: const TextStyle(fontWeight: MyFont.fontWeightMedium)),
//           TextSpan(
//             text: no2,
//           ),
//         ],
//       ),
//     );
//   }

//   static bool isValidToken(String token) {
//     MyUtils.printMe("uzair_1");
//     // String token =
//     //     '';

// //     payload_employeeIndex
// // payload_apns_token
// // payload_fcm_token
// // payload_serverIndex
// // payload_clientIndex
// // payload_Parameter
// // payload_URL
// // payload_exp
// // payload_iss
// // payload_aud

//     bool existed = false;

//     try {
//       Map<String, dynamic> payload = Jwt.parseJwt(token);
//       int i = 0;
//       for (var item in payload.keys) {
//         MyUtils.printMe("uzair_2");
//         if (item == "employeeIndex" ||
//             item == "apns_token" ||
//             item == "fcm_token" ||
//             item == "serverIndex" ||
//             item == "clientIndex" ||
//             item == "Parameter" ||
//             item == "URL" ||
//             item == "iss" ||
//             item == "aud" ||
//             item == "exp") {
//           existed = true;

//           if (item == "iss") {
//             if (payload.entries.elementAt(i).value.toString() !=
//                 dotenv.env['token_issuer']) {
//               existed = false;
//               print("exsist_${payload.entries.elementAt(i).value}");
//               break;
//             }
//           }

//           i++;
//         } else {
//           existed = false;
//           print("not_exsist_${item}");
//           break;
//         }
//       }
//     } catch (e) {}
//     MyUtils.printMe("uzair_3");
//     return existed;
//   }

//   // static Text boldTextPortion(
//   //   String fullText,
//   //   String textToBold,
//   // ) {
//   //   final texts = fullText.split(textToBold);
//   //   final textSpans = List.empty(growable: true);
//   //   texts.asMap().forEach((index, value) {
//   //     textSpans.add(TextSpan(text: value));
//   //     if (index < (texts.length - 1)) {
//   //       textSpans.add(TextSpan(
//   //         text: textToBold,
//   //         style: const TextStyle(fontWeight: FontWeight.bold),
//   //       ));
//   //     }
//   //   });
//   //   return Text.rich(
//   //     TextSpan(
//   //       children: <TextSpan>[...textSpans],
//   //     ),
//   //   );
//   // }
// }
