import 'package:app/features/auth/auth.dart';
import 'package:app/features/base/base.dart';
import 'package:app/features/category/category.dart';
import 'package:app/features/category/presentation/screens/details_screen.dart';
import 'package:app/features/category/presentation/screens/details_screen_super_market.dart';

import 'package:app/features/category/presentation/screens/market_screen.dart';
import 'package:app/features/popup/popup.dart';
import 'package:app/features/support/support.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/login': (_) => const LoginScreen(),
  '/loadingAuth': (_) => const LoadingAuth(),
  '/register': (_) => const RegisterScreen(),
  '/restore': (_) => const RestoreScreen(),
  '/profile': (_) => const ProfileScreen(),
  '/': (_) => const MenuScreen(),
  '/map': (_) => const MapScreen(),
  '/favorite': (_) => FavoriteScreen(),
  '/popup': (_) => const PopUpScreen(),
  '/answerSupport': (_) => const ResponseSupport(),
  '/support': (_) => const QuestionScreen(),
  '/messagesupport': (_) => const MessageSupportScreen(),
  '/restaurant': (_) => const RestaurantScreen(),
  '/details': (_) => const DetailScreen(),
  '/detailsBakery': (_) => const DetailsBakeryScreen(),
  '/detailsMarket': (_) => const DetailsSuperMarketScreen(),
  '/bakery': (_) => const BakeryScreen(),
  '/market': (_) => const MarketScreen(),
  '/term': (_) => const Term(),
  '/policy': (_) => const Policy(),
  '/thanks': (_) => const ThanksScreen(),
};
