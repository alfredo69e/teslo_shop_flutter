part of'./mappers.dart';

class ProductsMapper {

      static jsonToEntity(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: double.parse( json["price"].toString() ) ,
        description: json["description"],
        slug: json["slug"],
        stock: json["stock"],
        sizes: json["sizes"] == null ? [] : List<String>.from(json["sizes"].map((size) => size!)),
        gender: json["gender"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"].map((tag) => tag!)),
        images:  json["images"] == null 
          ? [] 
          : List<String>.from(json["images"].map((image) =>  image.startsWith('http') ? image : '${Environment.apiUrl}/files/product/$image' )),
        user: UserMapper.userJsonToEntity(json["user"]),
    );

}