part of'./screens.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon( Icons.add ),
        onPressed: () => context.push('/product/new'),
      ),
    );
  }
}


class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {

  final ScrollController scrollController =ScrollController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {

    ref.read( productsProvider.notifier ).loadNextPage();

    scrollController.addListener(() {
      if( ( scrollController.position.pixels + 400 ) >= scrollController.position.maxScrollExtent ) {
        ref.read( productsProvider.notifier ).loadNextPage();
      }
    });

    
  
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context, ) {

    final productsState = ref.watch( productsProvider );

    return Padding(
       padding: const EdgeInsets.symmetric( horizontal: 10 ),
       child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2, 
        mainAxisSpacing: 20,
        crossAxisSpacing: 35,
        itemCount: productsState.products.length,
        itemBuilder: ( context, index ) {

          final product = productsState.products[ index ];

          return GestureDetector(
            onTap: () => context.push( '/product/${ product.id }' ),
            child: ProductCard(product: product));
        } 
       ),
      );
  }
}