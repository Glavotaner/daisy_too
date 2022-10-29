part of '../messages.dart';

class SwipeHint extends StatelessWidget {
  const SwipeHint({required this.hint, required this.arrows, Key? key})
      : super(key: key);

  static animated({required PageController pageController}) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        final page = pageController.page ?? 0;
        String hint = 'Swipe oop to send kiss';
        Icon arrows = const Icon(Icons.arrow_upward);
        AlignmentGeometry alignment = Alignment.bottomCenter;
        if (page > 0.6) {
          hint = 'Swipe down to ask for kiss';
          arrows = const Icon(Icons.arrow_downward);
          alignment = Alignment.topCenter;
        }
        final distanceFromMiddle = (page - 0.5).abs();
        return AnimatedAlign(
          alignment: alignment,
          duration: Duration.zero,
          child: Opacity(
            opacity: distanceFromMiddle * 1.5,
            child: SwipeHint(
              hint: hint,
              arrows: arrows,
            ),
          ),
        );
      },
    );
  }

  final String hint;
  final Icon arrows;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        arrows,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            hint,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        arrows,
      ],
    );
  }
}