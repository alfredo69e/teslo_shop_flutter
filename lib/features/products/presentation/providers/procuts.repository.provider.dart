part of'./providers.dart';

final productsRepositryProvider = Provider< ProductsRepository >((ref) {

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDataSourceImpl( accessToken: accessToken )
  );

  return productsRepository;

});