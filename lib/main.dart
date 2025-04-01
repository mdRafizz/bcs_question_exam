import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.resetRootNavigator();

  await GetStorage.init();

  runApp(BCSPrelimPreparation());
}

class BCSPrelimPreparation extends StatefulWidget {
  const BCSPrelimPreparation({super.key});

  @override
  State<BCSPrelimPreparation> createState() => _BCSPrelimPreparationState();
}

class _BCSPrelimPreparationState extends State<BCSPrelimPreparation>
    with WidgetsBindingObserver {
  final _appLinks = AppLinks();
  late StreamSubscription _linkSubscription;

  // Uri? _pendingUri;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initDeepLinks();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed - Checking stored token...");
      _navigateToResetPassword();
    }
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });

    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }
  }

  void _handleDeepLink(Uri uri) {
    debugPrint("Deep link received: ${uri.toString()}");

    if (uri.host == "reset-password") {
      final token = uri.queryParameters["token"];
      if (token != null) {
        GetStorage().write("reset_token", token);
        _navigateToResetPassword();
      }
    }
  }

  void _navigateToResetPassword() {
    final token = GetStorage().read("reset_token");
    if (token != null) {
      Future.delayed(Duration(milliseconds: 500), () {
        Get.toNamed(Routes.RESET_PASSWORD, arguments: {'token': token});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384, 854),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          // showPerformanceOverlay: true,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff37c999),
            ),
          ),
          scrollBehavior: CupertinoScrollBehavior(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          unknownRoute: GetPage(
            name: "/not-found",
            page:
                () => Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: ReusableText(
                      'Please click on the link again without closing the app',
                    ),
                  ),
                ),
          ),
        );
      },
      // child: HomeView(),
    );
  }
}

