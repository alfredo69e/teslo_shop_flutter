part of'./../config.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read( authProvider.notifier );
  return GoRouterNotifier( authNotifier );
});

class GoRouterNotifier extends ChangeNotifier {

  final AuthNotifier _authNotifier;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus _authStatus = AuthStatus.checking;


  AuthStatus get authStatus => _authStatus;

  set authStatus( AuthStatus data ) {
    _authStatus = data;
    notifyListeners();
  }

}