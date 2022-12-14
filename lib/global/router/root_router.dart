import 'package:daisy_too/messages/ui/messages.dart';
import 'package:daisy_too/splash/splash.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';

import 'package:daisy_too/users/ui/registration.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  RootRouter({Key? key}) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final isOnboarded = context.select((UsersCubit cubit) {
      return cubit.state.isOnboarded;
    });
    return Navigator(
      pages: [
        if (isOnboarded ?? false) MessagesPage.page(),
        if (isOnboarded != null && !isOnboarded) Registration.page(),
        if (isOnboarded == null) SplashScreen.page(),
      ],
      onPopPage: (route, result) => false,
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.value();
  }
}
