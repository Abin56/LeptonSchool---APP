import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lepton_school/controllers/bloc/user_phone_otp/auth_state.dart';
import 'package:lepton_school/controllers/userCredentials/user_credentials.dart';
import 'package:lepton_school/firebase_options.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:lepton_school/view/constant/responsive.dart';
import 'package:lepton_school/view/language/language.dart';
import 'package:lepton_school/view/language/select_language/select_language.dart';
import 'package:lepton_school/view/pages/chat_gpt/providers/chats_provider.dart';
import 'package:lepton_school/view/pages/chat_gpt/providers/models_provider.dart';
import 'package:lepton_school/view/pages/login/dujo_login_screen.dart';
import 'package:lepton_school/view/pages/splash_screen/splash_screen.dart';
// import 'package:play_video/play_video.dart';
import 'package:provider/provider.dart';

import 'controllers/bloc/user_phone_otp/auth_cubit.dart';
import 'helper/shared_pref_helper.dart';
import 'local_database/parent_login_database.dart';

late Box<DBParentLogin> parentdataDB;

final navigatorKey = GlobalKey<NavigatorState>();

//function to listen to background changes
Future _firebasebackgrounMessage(RemoteMessage message) async {
  if (message.notification != null) {
    // log("some notification recieved in background");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling  a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(DBParentLoginAdapter().typeId)) {
    Hive.registerAdapter(DBParentLoginAdapter());
  }
  parentdataDB = await Hive.openBox<DBParentLogin>('parentloginAuth');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// try {
//       await FirebaseAppCheck.instance
//       // Your personal reCaptcha public key goes here:
//       .activate(
//     androidProvider:kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
//     appleProvider: AppleProvider.debug,
//     webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),);
// } catch (e) {
//   log(e.toString());

// }
  //creating shared preference
  await SharedPreferencesHelper.initPrefs();
  // await PlayVideoRender.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ///////////////////////////////Push notification Command
  //initialize firebase messaging


  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ///[languageCode]and[countryCode] will be change [updateLanguage] function on select language page
  final String languageCode =
      SharedPreferencesHelper.getString("langCode") ?? "en";
  final String countryCode =
      SharedPreferencesHelper.getString("langCode") ?? "US";

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        designSize: const Size(423.5294196844927, 945.8823706287004),
        builder: (context) {
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => ModelsProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ChatProvider(),
                ),
              ],
              child: GetMaterialApp(
                theme: ThemeData(
                    tabBarTheme: TabBarTheme(
                      unselectedLabelColor: cWhite,
                      labelColor: Colors.blue[100],
                      indicatorColor: Colors.green,
                    ),
                    // unselectedWidgetColor: cWhite,
                    appBarTheme: const AppBarTheme(foregroundColor: cWhite)),
                translations: GetxLanguage(),
                locale: Locale(languageCode, countryCode),
                debugShowCheckedModeBanner: false,
                home: BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (oldState, newState) {
                    return oldState is AuthInitialState;
                  },
                  builder: (context, state) {
                    ResponsiveApp.serMq(context);
                    if (state is AuthLoggedInState) {
                      if (SharedPreferencesHelper.getString("langCode") !=
                          null) {
                        return const SplashScreen();
                      } else {
                        return const SelectLanguage();
                      }
                    } else if (state is AuthLoggedOutState) {
                      if (SharedPreferencesHelper.getString("langCode") !=
                          null) {
                        return const SplashScreen();
                      } else {
                        return const SelectLanguage();
                      }
                    }
                    if (SharedPreferencesHelper.getString("langCode") != null) {
                      return const SplashScreen();
                    } else {
                      return const SelectLanguage();
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}

////

checkingSchoolActivate(BuildContext context) async {
  final checking = await FirebaseFirestore.instance
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .get();

  if (checking.data()!['deactive'] == true) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return  const DujoLoginScren();
      },
    ));
    // Get.offAll(() => const DujoLoginScren());
    // ignore: use_build_context_synchronously
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Your School is Deactivated')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) async {
                  await SharedPreferencesHelper.clearSharedPreferenceData();
                  UserCredentialsController.clearUserCredentials();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return const DujoLoginScren();
                    },
                  ));
                  //  Get.offAll(() => const DujoLoginScren());
                });
              },
            ),
          ],
        );
      },
    );
  } else {
    return;
  }
}
