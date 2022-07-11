import 'dart:html';

import 'routing_controller.dart';

NavigationHistory createNavigationHistory(StackRouter router) =>
    WebNavigationHistory(router);

class WebNavigationHistory extends NavigationHistory {
  WebNavigationHistory(this.router);

  @override
  StackRouter router;

  int get _currentIndex {
    final state = window.history.state;
    if (state is Map) {
      return state['serialCount'] ?? 0;
    }
    return 0;
  }

  @override
  bool get canNavigateBack => _currentIndex > 0;

  @override
  int get length => window.history.length;

  @override
  void back() => window.history.back();

  @override
  void forward() => window.history.forward();
}
