part of'./../../../features.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl
    )
  );

  @override
  Future<User> checkAuthStatus(String token) async {
    try {

      final response = await dio.get( '/auth/check-status', options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));

      final user = UserMapper.userJsonToEntity( response.data );

      return user;
      
    } on DioException catch ( err ) {
     
     if( err.response?.statusCode == 401 ){
         throw CustomError('Token incorrecto');
      }
      throw Exception();
      } catch (e) {
        throw Exception();
      }
  }

  @override
  Future<User> login(String email, String password) async {
    
    
    try {

      final response = await dio.post( '/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity( response.data );

      return user;
      
    } on DioException catch (err) {
      if( err.response?.statusCode == 401 ){
         throw CustomError(err.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( err.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }

}