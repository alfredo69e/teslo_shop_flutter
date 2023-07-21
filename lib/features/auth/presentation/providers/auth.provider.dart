part of'./../../../features.dart';


final authProvider = StateNotifierProvider< AuthNotifier, AuthState >((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValuesStoragesService = KeyValuesStoragesServiceImpl();
  

  return AuthNotifier(
    authRepository: authRepository,
    keyValuesStoragesService: keyValuesStoragesService
  );
});

class AuthNotifier extends StateNotifier<AuthState> {

   final AuthRepository authRepository;
   final KeyValuesStoragesService keyValuesStoragesService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValuesStoragesService
  }): super( AuthState() ) {
    checkAuthStatus();
  }
  
  Future<void> loginUser( String email, String password ) async {

    await Future.delayed( const Duration( milliseconds: 500) );

    try {

      final user = await authRepository.login(email, password);

      _setLoggedUser( user );
      
    } on WrongCredentials {
      logout('Credential no son correctas');
    } catch ( err ) {
      logout('Err no controlado');
    }

  }

  void registerUser( String email, String password, String fullName ) async {
    
  }

  void checkAuthStatus() async {

    final  token = await keyValuesStoragesService.getValue<String>('token') ?? '';

    if( token.isEmpty ) return logout();

    try {

       final user = await authRepository.checkAuthStatus( token );
      _setLoggedUser( user );
      
    } catch ( err ) {
      logout();
    }

    
  }

  _setLoggedUser( User user ) async {

    await keyValuesStoragesService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errMessage: ''
    );
  }

  Future<void> logout([ String? errMessage ]) async {

    await keyValuesStoragesService.removeValue('token');

     state = state.copyWith(
      user: null,
      authStatus: AuthStatus.noAuthenticated,
      errMessage: errMessage
    );
  }

}

enum AuthStatus { checking, authenticated, noAuthenticated }

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errMessage;

  AuthState( {
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errMessage: errMessage ?? this.errMessage,
  );

}