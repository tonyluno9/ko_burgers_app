import 'package:go_router/go_router.dart';

// IMPORTA TODAS LAS SCREEN QUE USAS
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/success_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';

import 'models/product_model.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/menu', builder: (_, __) => const MenuScreen()),
    GoRoute(path: '/chat', builder: (_, __) => const ChatScreen()),

    // 📌 ESTA RUTA DEBES TENERLA SÍ O SÍ
    GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),

    GoRoute(path: '/payment', builder: (_, __) => const PaymentScreen()),
    GoRoute(path: '/success', builder: (_, __) => const SuccessScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
    GoRoute(path: '/offers', builder: (_, __) => const OffersScreen()),
    GoRoute(path: '/orders', builder: (_, __) => const OrdersScreen()),

    // PRODUCT DETAIL
    GoRoute(
      path: '/product',
      builder: (_, state) {
        final product = state.extra as Product;
        return ProductDetailScreen(product: product);
      },
    ),
  ],
);
