import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_app/ui/home_page/home_page.dart';
import 'package:wedding_app/ui/register_page/register_page.dart';

import 'blocs/auth/auth_bloc.dart';

final dataKey = GlobalKey();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Event',
              // localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
              // supportedLocales: const [
              //   Locale('ru'),
              // ],
              theme: ThemeData(
                textTheme: TextTheme(
                  headline1: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'georgia',
                    color: const Color(0xFF00312C),
                  ),
                  headline3: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: const Color(0xFF00312C),
                  ),
                  bodyText1: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    color: const Color(0xFF00312C),
                  ),
                  button: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: const Color(0xFF000000).withOpacity(0.5),
                  ),
                ),
              ),
              home: const HomePage(),
              routes: {
                'home_page': (context) => const HomePage(),
                'reg_page': (context) => const RegisterPage(),
              });
        },
      ),
    );
  }
}
