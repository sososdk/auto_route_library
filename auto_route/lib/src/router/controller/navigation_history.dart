part of 'routing_controller.dart';

abstract class NavigationHistory with ChangeNotifier {
  StackRouter get router;

  void rebuildUrl() {
    final newState = UrlState.fromSegments(
      router.currentSegments,
      shouldReplace: _isUrlStateMarkedForReplace,
    );
    _unMarkUrlStateForReplace();
    onNewUrlState(newState);
  }

  bool _isUrlStateMarkedForReplace = false;

  bool get isUrlStateMarkedForReplace => _isUrlStateMarkedForReplace;

  void markUrlStateForReplace() => _isUrlStateMarkedForReplace = true;

  void _unMarkUrlStateForReplace() => _isUrlStateMarkedForReplace = false;

  UrlState _urlState = UrlState.fromSegments(const []);

  @protected
  void onNewUrlState(UrlState newState, {bool notify = true}) {
    if (_urlState != newState) {
      _urlState = newState;
      if (notify) {
        notifyListeners();
      }
    }
  }

  bool isRouteActive(String routeName) =>
      urlState.segments.any((route) => route.name == routeName);

  bool isRouteDataActive(RouteData data) =>
      urlState.segments.any((route) => route == data.route);

  bool isPathActive(String pattern) => RegExp(pattern).hasMatch(urlState.path);

  UrlState get urlState => _urlState;

  bool get canNavigateBack;

  int get length;

  void back();

  void forward();
}
