import 'package:food_quest/core/ui/widgets/notFound/not_found_page.dart';
import 'package:food_quest/core/utils/binding/internet_binding.dart';
import 'package:food_quest/main/food/di/food_binding.dart';
import 'package:food_quest/main/food/presentation/page/add_food_page.dart';
import 'package:food_quest/main/nav/di/navigation_binding.dart';
import 'package:food_quest/main/nav/presentation/page/navigation_page.dart';
import 'package:food_quest/main/splash/di/splash_binding.dart';
import 'package:food_quest/main/splash/presentation/page/splash_page.dart';
import 'package:food_quest/main/user/features/auth/login/di/login_binding.dart';
import 'package:food_quest/main/user/features/auth/login/presentation/page/login_page.dart';
import 'package:food_quest/main/user/features/auth/signin/di/signin_binding.dart';
import 'package:food_quest/main/user/features/auth/signin/presentation/page/signin_page.dart';
import 'package:get/get.dart';

final notFoundPage = GetPage(
  name: NotFoundPage.routeName,
  page: () => const NotFoundPage(),
);

final appPage = [
  GetPage(
    name: "/splash",
    page: () => const SplashPage(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: const NavigationPage().routeName,
    page: () => const NavigationPage(),
    binding: NavigationBinding(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: const LoginPage().routeName,
    page: () => const LoginPage(),
    bindings: [
      InternetBinding(),
      LoginBinding(),
    ],
  ),
  GetPage(
    name: const AddFoodPage().routeName,
    page: () => const AddFoodPage(),
  ),
  GetPage(
    name: const SigninPage().routeName,
    page: () => const SigninPage(),
    binding: SigninBinding(),
  ),
  GetPage(
    name: NotFoundPage.routeName,
    page: () => const NotFoundPage(),
    binding: FoodBinding(),
  ),
];
