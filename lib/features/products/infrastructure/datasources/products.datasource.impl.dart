part of'./datasources.dart';



class ProductsDataSourceImpl extends ProductsDataSource {

  late final Dio dio;
  final String accessToken;

  ProductsDataSourceImpl({
    required this.accessToken,
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );

  Future<String> _uploadFile( String path ) async {
    try {

      final fileName = path.split('/').last;
      final data = FormData.fromMap({ 'file': MultipartFile.fromFileSync( path, filename: fileName ) });
      final response = await dio.post('/file/product', data: data );

      return response.data['image'];
      
    } catch ( err ) {
      throw Exception();
    }
  }

  Future<List<String>> _uploadPhotos( List<String> photos ) async {

    final photosToUpload = photos.where((element) => element.contains('/') ).toList();
    final photosToIgnore = photos.where((element) => !element.contains('/') ).toList();

    final List<Future<String>> uploadJob = photosToUpload.map( _uploadFile ).toList();

    final newImages = await Future.wait( uploadJob );

    return [ ...photosToIgnore, ...newImages ];

  }

  @override
  Future<Product> creadtUpdateProduct(Map<String, dynamic> productLike) async {
   try {

      final String? productId = productLike['id'];
      final String method = ( productId == null ) ? 'POST' : 'PATCH';
      final String url = ( productId == null ) ? '/products' : '/products/$productId';
      productLike.remove('id');
      productLike['images'] = await _uploadPhotos( productLike['images'] );
 
      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method
        )
      );
   
      return ProductsMapper.jsonToEntity( response.data ) ;
      
    } on DioException catch ( err ) {
      if( err.response!.statusCode == 404 ) throw ProductNotFound();
      throw Exception();
      
    } catch ( err ) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    
    try {

      final response = await dio.get('/products/$id');
   
      return ProductsMapper.jsonToEntity( response.data ) ;
      
    } on DioException catch ( err ) {

      if( err.response!.statusCode == 404 ) throw ProductNotFound();
      throw Exception();
      
    } catch ( err ) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (final product in response.data ?? [] ) {
      products.add( ProductsMapper.jsonToEntity( product ) );
    }

    return products;
    
  }

  @override
  Future<List<Product>> searchProductByItem(String term) {
    // TODO: implement serarchProductByItem
    throw UnimplementedError();
  }

}