part of'./repositories.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  final ProductsDataSource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Product> creadtUpdateProduct(Map<String, dynamic> productLike) {
   return datasource.creadtUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById( id );
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByItem(String term) {
    return datasource.searchProductByItem(term);
  }

}