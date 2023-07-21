part of'../../infrastructure.dart';

abstract class KeyValuesStoragesService {

  Future<void> setKeyValue<T>( String key, T value );
  Future<T?> getValue<T>( String key );
  Future<bool> removeValue( String key );

}