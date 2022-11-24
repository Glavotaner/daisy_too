import 'dart:async';

import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:daisy_too/messages/ui/components/kiss_tap.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KissSelection extends StatefulWidget {
  const KissSelection({Key? key}) : super(key: key);

  @override
  State<KissSelection> createState() => _KissSelectionState();
}

class _KissSelectionState extends State<KissSelection>
    with TickerProviderStateMixin {
  final List<Kiss> kisses = Kiss.kisses;
  late PageController _pageController;

  _animateToInitialPage() {
    final middleKissIndex = (kisses.length / 2).floor();
    Timer(const Duration(milliseconds: 100), () {
      _pageController.animateToPage(
        middleKissIndex,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.7,
    );
    _animateToInitialPage();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: kisses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (ctx, _) {
                if (!_pageController.hasClients ||
                    !_pageController.position.hasContentDimensions) {
                  return const SizedBox();
                }
                final page = _pageController.page!;
                final selectedIndex = page.roundToDouble();

                final pageScrollAmount = page - selectedIndex;

                final maxScrollDistance = kisses.length / 2;

                final pageDistanceFromSelected =
                    (selectedIndex - index + pageScrollAmount).abs();

                final percentFromCenter =
                    1.0 - pageDistanceFromSelected / maxScrollDistance;

                final itemScale = 0.5 + (percentFromCenter * 0.5);
                final opacity = 0.25 + (percentFromCenter * 0.75);

                return Transform.scale(
                  scale: itemScale,
                  child: Opacity(
                    opacity: opacity,
                    child: _Kiss(kiss: kisses[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Kiss extends StatelessWidget {
  const _Kiss({required this.kiss, Key? key}) : super(key: key);

  final Kiss kiss;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(kiss.assetPath!),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Chip(
                    label: Text(
                      kiss.type,
                      style: const TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.redAccent.withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
          KissTap(
            onTap: () {
              context.read<KissCubit>().sendKiss(kiss);
            },
          )
        ],
      ),
    );
  }
}
