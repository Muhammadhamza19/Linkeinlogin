import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oauth2_client/linkedin_oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
// import 'package:http/http.dart' as http;
import 'package:linkedin_login/linkedin_login.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:oauth2_client/oauth2_response.dart';
import 'dart:html';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'redirect.dart';
import 'Next.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import 'dart:js' as js;

void main() async {
  //usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String route = '/redirect';
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: null,
      initialData: null,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // _HomeState.route: (context) => HomePage(),
          Redirect.route: (context) => Redirect(),
        },
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// class User {
//   final String email;
//   final String password;
//   // final bool isCool;
//   // final int postCount;

//   User({this.email, this.password});

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> user = Map<String, dynamic>();
//     user["email"] = email;
//     user["password"] = this.password;

//     // user["isCool"] = this.isCool;
//     // user["postCount"] = this.postCount;
//     return user;
//   }
// // }

// User user = User(id: 1, name: "John", isCool: true, postCount: 4);
// await SessionManager().set('user', user);
// User u = User.fromJson(await SessionManager().get("user"));

// {"web":{"client_id":"889579774302-ge5gsshk9d2qsgakbj3gp5e62u9ovopt.apps.googleusercontent.com","project_id":"apitesting-366607","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"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"}}

class _HomeState extends State<Home> {
  var hlp;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(),
                      child: Text("Sign in with Linkedin"),
                      onPressed: () {
                        // Navigator.of(context).pushNamed(Redirect.route);
                        // pushNewScreenWithRouteSettings(
                        //   context,
                        //   settings: RouteSettings(name: "redirect"),
                        //   screen: Redirect(),
                        //   withNavBar: true,
                        //   pageTransitionAnimation:
                        //       PageTransitionAnimation.cupertino,
                        // );
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => Redirect()));
                        fetchFiles();
                      }

                      // print("token_is_${hlp}");
                      // fetchdata();

                      // print("helloo");
                      // Navigator.pop(context);

                      // {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (BuildContext context) => LinkedInUserWidget(
                      //         appBar: AppBar(
                      //           title: Text('OAuth User'),
                      //         ),
                      //         // destroySession: logoutUser,
                      //         redirectUrl: 'www.google.com',
                      //         clientId: '77o7d8snl4rx5u',
                      //         clientSecret: 'IHrixp63RLAz0o8c',
                      //         projection: [
                      //           ProjectionParameters.id,
                      //           ProjectionParameters.localizedFirstName,
                      //           ProjectionParameters.localizedLastName,
                      //           ProjectionParameters.firstName,
                      //           ProjectionParameters.lastName,
                      //           ProjectionParameters.profilePicture,
                      //         ],
                      //         onGetUserProfile: (UserSucceededAction linkedInUser) {
                      //           // linkedInUser = linkedInUser(
                      //           //   firstName:
                      //           //       linkedInUser?.firstName?.localized?.label,
                      //           //   lastName: linkedInUser?.lastName?.localized?.label,
                      //           //   email: linkedInUser
                      //           //       ?.email?.elements[0]?.handleDeep?.emailAddress,
                      //           //   profileImageUrl: linkedInUser
                      //           //       ?.profilePicture
                      //           //       ?.displayImageContent
                      //           //       ?.elements[0]
                      //           //       ?.identifiers[0]
                      //           //       ?.identifier,
                      //           // );

                      //           Navigator.pop(context);
                      //         },
                      //       ),
                      //       fullscreenDialog: true,
                      //     ),
                      //   );
                      // },
                      ))
            ],
          )
        ],
      ),
    );
  }

  Future<void> fetchFiles() async {
    print("uzair_1");

    //Instantiate an OAuth2Client...
   Future<void> fetchProfile() async {
    final tokenEndpoint = Uri.https('www.linkedin.com', 'oauth/v2/accessToken');
    final redirectUri = Uri.parse('http://localhost:65462');
    final clientId = '78n6twe89uhn3o';
    final clientSecret = 'uJceXryAaZLbfVg3';
    final scopes = ['r_emailaddress', 'r_liteprofile'];

    try {
      final authorizationUrl =
          Uri.https('www.linkedin.com', 'oauth/v2/authorization', {
        'response_type': 'code',
        'client_id': clientId,
        'redirect_uri': redirectUri.toString(),
        'scope': scopes.join(' ')
      });
      final result = await FlutterWebAuth2.authenticate(
        url: authorizationUrl.toString(),
        callbackUrlScheme: redirectUri.scheme,
      );

      final Code = Uri.parse(result).queryParameters['code'];

      final response = await http.post(
        tokenEndpoint,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: <String, String>{
          'redirect_uri': redirectUri.toString(),
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'authorization_code',
          'code': Code!,
        },
      );

      final accessToken = jsonDecode(response.body)['access_token'];
      print("Here is the Token ${accessToken}");
    } catch (e) {
      // Handle authentication error
      print("Authentication error: $e");
    }
  }
}
