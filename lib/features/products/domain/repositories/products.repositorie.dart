part of'./repositories.dart';

 abstract class ProductsRepository {

  Future<List<Product>> getProductsByPage({ int limit = 10, int offset = 0 });
  
  Future<Product> getProductById( String id );
  
  Future<List<Product>> searchProductByItem( String term );
  
  Future<Product> creadtUpdateProduct( Map<String, dynamic> productLike );

}