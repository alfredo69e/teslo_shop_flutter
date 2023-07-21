part of'./widgets.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({
    required this.product,
    super.key
   });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _ImagesViewer( images: product.images ),

        Text( product.title ),

        const SizedBox( height: 20 )


      ],
    );
  }
}

class _ImagesViewer extends StatelessWidget {

  final List<String> images;

  const _ImagesViewer({
    this.images = const [],
    });

  @override
  Widget build(BuildContext context) {
    return ( images.isEmpty )
    ? ClipRRect(
        borderRadius: BorderRadius.circular( 20 ),
        child: Image.asset('./assets/images/no-image.jpg', fit: BoxFit.cover, height: 250),
      )
    : ClipRRect(
        borderRadius: BorderRadius.circular( 20 ),
        child: FadeInImage(
          fit: BoxFit.cover,
          image: NetworkImage( images.first ),
          height: 250,
          fadeOutDuration: const Duration( milliseconds: 100 ),
          fadeInDuration: const Duration( milliseconds: 200 ),
          placeholder: const AssetImage( './assets/loaders/bottle-loader.gif' ),
        ),
      );
  }
}