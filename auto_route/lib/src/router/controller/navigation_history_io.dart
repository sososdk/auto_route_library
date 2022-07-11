import 'package:collection/collection.dart';

import '../../matcher/route_match.dart';
import '../parser/route_information_parser.dart';
import 'routing_controller.dart';

NavigationHistory createNavigationHistory(StackRouter router) =>
    NativeNavigationHistory(router);

class _HistoryEntry {
  final RouteMatch route;
  final String url;

  const _HistoryEntry(this.route, this.url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _HistoryEntry &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() {
    return route.flattened.map((e) => e.name).join('->');
  }
}

class NativeNavigationHistory extends NavigationHistory {
  NativeNavigationHistory(this.router);

  @override
  final StackRouter router;

  final _entries = <_HistoryEntry>[];

  @override
  void onNewUrlState(UrlState newState, {bool notify = true}) {
    super.onNewUrlState(newState, notify: notify);

    if (newState.shouldReplace && length > 0) {
      _entries.removeLast();
    }

    if (_currentUrl == newState.url) return;
    _addEntry(newState);
  }

  @override
  bool get canNavigateBack => length > 1;

  @override
  int get length => _entries.length;

  String get _currentUrl => _entries.lastOrNull?.url ?? '';

  void _addEntry(UrlState urlState) {
    if (!urlState.hasSegments) return;
    final route = UrlState.toHierarchy(urlState.segments);
    // limit history registration to 20 entries
    if (_entries.length > 20) {
      _entries.removeAt(0);
    }
    _entries.add(_HistoryEntry(route, urlState.url));
  }

  @override
  void back() {
    if (canNavigateBack) {
      _entries.removeLast();
      router.navigateAll([_entries.last.route]);
    }
  }

  @override
  void forward() => throw UnsupportedError(
      'forward navigation is not supported for non-web platforms');
}
