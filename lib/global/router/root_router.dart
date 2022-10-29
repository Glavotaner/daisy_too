import 'package:daisy_too/messages/ui/messages.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:daisy_too/users/ui/registration.dart';
import 'package:flutter/widgets.dart';

class RootRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  RootRouter({Key? key}) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final pages = <Page>[];
    if (UsersProvider.isOnboarded(context)) {
      pages.add(MessagesPage.page());
    } else {
      pages.add(Registration.registration());
    }
    return Navigator(
      pages: pages,
      onPopPage: (route, result) => false,
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.value();
  }
}
