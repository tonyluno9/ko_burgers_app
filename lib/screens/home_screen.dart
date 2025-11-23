import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/posts_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/section_title.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF000000), Color(0xFF0047FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // TOP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/ko_logo.png',
                            width: 42,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "KO Burgers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => context.push('/profile'),
                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // HERO BANNER
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "🔥 Promo del día",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "LVL 1 + papas + bebida por \$119.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // BODY (SCROLL)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitle(
                                title: "Ofertas",
                                actionText: "Ver todas",
                                onAction: () => context.push('/offers'),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 140,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    _offerCard(
                                      title: "Combo KO",
                                      desc: "LVL 2 + papas + bebida",
                                      price: 149,
                                    ),
                                    _offerCard(
                                      title: "Doble LVL 1",
                                      desc: "Para compartir",
                                      price: 159,
                                    ),
                                    _offerCard(
                                      title: "Noche KO",
                                      desc: "3 LVL 3 para la banda",
                                      price: 399,
                                    ),
                                    _offerCard(
                                      title: "Combo KO Rookie", 
                                      desc: "LVL 1 + papas + bebida", 
                                      price: 119,
                                    ),
                                     _offerCard(
                                      title: "Combo Guerrero", 
                                      desc: "LVL 2 + papas grandes", 
                                      price: 159,
                                    ),
                                     _offerCard(
                                      title: "Combo Campeón KO", 
                                      desc: "LVL 3 + papas + postre", 
                                      price: 199,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              const SectionTitle(title: "Noticias"),
                              const SizedBox(height: 8),
                              posts.when(
                                data: (list) => Column(
                                  children: list
                                      .map((p) => PostCard(post: p))
                                      .toList(),
                                ),
                                loading: () => const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                )),
                                error: (_, __) => const Text(
                                    "Error cargando publicaciones"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 0),
    );
  }

  Widget _offerCard({
    required String title,
    required String desc,
    required double price,
  }) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const Spacer(),
          Text(
            "\$${price.toStringAsFixed(0)}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
