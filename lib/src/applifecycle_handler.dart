import 'package:flutter/widgets.dart';

class ApplifecycleHandler extends StatefulWidget {
  const ApplifecycleHandler({
    super.key,
    required this.child,
    this.binding,
    this.onResume,
    this.onInactive,
    this.onHide,
    this.onShow,
    this.onPause,
    this.onRestart,
    this.onDetach,
    this.onExitRequested,
    this.onStateChange,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The [WidgetsBinding] to listen to for application lifecycle events.
  ///
  /// Typically, this is set to [WidgetsBinding.instance], but may be
  /// substituted for testing or other specialized bindings.
  ///
  /// Defaults to [WidgetsBinding.instance].
  final WidgetsBinding? binding;

  /// Called anytime the state changes, passing the new state.
  final ValueChanged<AppLifecycleState>? onStateChange;

  /// A callback that is called when the application loses input focus.
  ///
  /// On mobile platforms, this can be during a phone call or when a system
  /// dialog is visible.
  ///
  /// On desktop platforms, this is when all views in an application have lost
  /// input focus but at least one view of the application is still visible.
  ///
  /// On the web, this is when the window (or tab) has lost input focus.
  final VoidCallback? onInactive;

  /// A callback that is called when a view in the application gains input
  /// focus.
  ///
  /// A call to this callback indicates that the application is entering a state
  /// where it is visible, active, and accepting user input.
  final VoidCallback? onResume;

  /// A callback that is called when the application is hidden.
  ///
  /// On mobile platforms, this is usually just before the application is
  /// replaced by another application in the foreground.
  ///
  /// On desktop platforms, this is just before the application is hidden by
  /// being minimized or otherwise hiding all views of the application.
  ///
  /// On the web, this is just before a window (or tab) is hidden.
  final VoidCallback? onHide;

  /// A callback that is called when the application is shown.
  ///
  /// On mobile platforms, this is usually just before the application replaces
  /// another application in the foreground.
  ///
  /// On desktop platforms, this is just before the application is shown after
  /// being minimized or otherwise made to show at least one view of the
  /// application.
  ///
  /// On the web, this is just before a window (or tab) is shown.
  final VoidCallback? onShow;

  /// A callback that is called when the application is paused.
  ///
  /// On mobile platforms, this happens right before the application is replaced
  /// by another application.
  ///
  /// On desktop platforms and the web, this function is not called.
  final VoidCallback? onPause;

  /// A callback that is called when the application is resumed after being
  /// paused.
  ///
  /// On mobile platforms, this happens just before this application takes over
  /// as the active application.
  ///
  /// On desktop platforms and the web, this function is not called.
  final VoidCallback? onRestart;

  /// A callback used to ask the application if it will allow exiting the
  /// application for cases where the exit is cancelable.
  ///
  /// Exiting the application isn't always cancelable, but when it is, this
  /// function will be called before exit occurs.
  ///
  /// Responding [AppExitResponse.exit] will continue termination, and
  /// responding [AppExitResponse.cancel] will cancel it. If termination is not
  /// canceled, the application will immediately exit.
  final AppExitRequestCallback? onExitRequested;

  /// A callback that is called when an application has exited, and detached all
  /// host views from the engine.
  ///
  /// This callback is only called on iOS and Android.
  final VoidCallback? onDetach;

  @override
  State<ApplifecycleHandler> createState() => _ApplifecycleHandlerState();
}

class _ApplifecycleHandlerState extends State<ApplifecycleHandler> {
  AppLifecycleListener ?_listener;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(ApplifecycleHandler oldWidget) {
    super.didUpdateWidget(oldWidget);
    _unsubscribe();
    _subscribe();
  }

  void _subscribe() {
    _unsubscribe();
    _listener = AppLifecycleListener(
      binding: widget.binding,
      onResume: widget.onResume,
      onInactive: widget.onInactive,
      onHide: widget.onHide,
      onShow: widget.onShow,
      onPause: widget.onPause,
      onRestart: widget.onRestart,
      onDetach: widget.onDetach,
      onExitRequested: widget.onExitRequested,
      onStateChange: widget.onStateChange,
    );
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _unsubscribe() {
    _listener?.dispose();
    _listener = null;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
