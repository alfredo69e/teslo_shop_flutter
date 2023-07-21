part of'./screens.dart';

class ProductScreen extends ConsumerWidget {

  final String productId;

  const ProductScreen({
    required this.productId,
    super.key
  });

  void showSnackBar( BuildContext context ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product Actualizado'))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final productState = ref.watch( productProvider( productId ) );

    

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edict Product'),
          actions: [

            IconButton(
              onPressed: () async {

                 final photoPath = await CameraGalleryServiceImpl().selectPhoto();

                if( photoPath == null ) return;

                ref.read( productFromProvider( productState.product! ).notifier ).updateProductImage(photoPath);

              }, 
              icon: const Icon( Icons.photo_library_outlined )
            ),

            IconButton(
              onPressed: () async {

                final photoPath = await CameraGalleryServiceImpl().takePhoto();

                if( photoPath == null ) return;

                ref.read( productFromProvider( productState.product! ).notifier ).updateProductImage(photoPath);

              }, 
              icon: const Icon( Icons.camera_alt_outlined )
            )
    
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
    
            FocusScope.of(context).unfocus();
    
            if ( productState.product == null ) return; 
            
            ref.read( productFromProvider( productState.product!  ).notifier )
              .onFormSubmit()
              .then((value) {
                if( !value ) return;
    
                showSnackBar( context );
              });
    
    
    
          },
          child: const  Icon( Icons.save_as_outlined ),
        ),
        body: ( productState.isLoading ) ? const LoadingView() : _ProductView( product: productState.product! ),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {

  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final productForm = ref.watch( productFromProvider( product ) );

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
    
          SizedBox(
            height: 250,
            width: 600,
            child: _ImageGallery(images: productForm.images ),
          ),
    
          const SizedBox( height: 10 ),
          Center(child: Text( productForm.title.value, style: textStyles.titleSmall )),
          const SizedBox( height: 10 ),
          _ProductInformation( product: product ),
          
        ],
    );
  }
}


class _ProductInformation extends ConsumerWidget {
  final Product product;
  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final productForm = ref.watch( productFromProvider( product ) );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomProductField( 
            isTopField: true,
            label: 'Nombre',
            initialValue: productForm.title.value,
            onChanged: ref.read( productFromProvider(product).notifier ).onTitleChange,
            errorMessage: productForm.title.errorMessage,
          ),
          CustomProductField( 
            label: 'Slug',
            initialValue: productForm.slug.value,
            onChanged: ref.read( productFromProvider(product).notifier ).onSlugChange,
            errorMessage: productForm.slug.errorMessage,
          ),
          CustomProductField( 
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.price.value.toString(),
            onChanged: ( value ) => ref.read( productFromProvider(product).notifier ).onPriceChange( double.tryParse( value ) ?? -1 ),
            errorMessage: productForm.price.errorMessage,
          ),

          const SizedBox(height: 15 ),
          const Text('Extras'),

          _SizeSelector(
            
            selectedSizes: productForm.sizes,
            onChangeSizes: ref.read( productFromProvider(product).notifier ).onSizesChange,
            ),
          const SizedBox(height: 5 ),
          _GenderSelector( 
            selectedGender: productForm.gender,
            onChangeGender: ref.read( productFromProvider(product).notifier ).onGenderChange
           ),
          

          const SizedBox(height: 15 ),
          CustomProductField( 
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.inStock.value.toString(),
            onChanged: ( value ) => ref.read( productFromProvider(product).notifier ).onStockChange( int.tryParse( value ) ?? -1 ),
            errorMessage: productForm.inStock.errorMessage,
          ),

          CustomProductField( 
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: productForm.description,
            onChanged: ref.read( productFromProvider(product).notifier ).onDescriptionChange,
          ),

          CustomProductField( 
            isBottomField: true,
            maxLines: 2,
            label: 'Tags (Separados por coma)',
            keyboardType: TextInputType.multiline,
            initialValue: productForm.tags,
            onChanged: ref.read( productFromProvider(product).notifier ).onTagsChange,
          ),


          const SizedBox(height: 100 ),
        ],
      ),
    );
  }
}


class _SizeSelector extends StatelessWidget {
  final List<String> selectedSizes;
  final List<String> sizes = const['XS','S','M','L','XL','XXL','XXXL'];
  final Function(List<String> selectedSizes) onChangeSizes;

  const _SizeSelector({
    required this.selectedSizes,
    required this.onChangeSizes
    });


  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      emptySelectionAllowed: true,
      showSelectedIcon: false,
      segments: sizes.map((size) {
        return ButtonSegment(
          value: size, 
          label: Text(size, style: const TextStyle(fontSize: 10))
        );
      }).toList(), 
      selected: Set.from( selectedSizes ),
      onSelectionChanged: (newSelection) {
        FocusScope.of( context ).unfocus();
        onChangeSizes( List.from( newSelection ) );
      },
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String selectedGender;
  final List<String> genders = const['men','women','kid'];
  final List<IconData> genderIcons = const[
    Icons.man,
    Icons.woman,
    Icons.boy,
  ];
  final void Function(String selectedGender) onChangeGender;


  const _GenderSelector({
    required this.selectedGender,
    required this.onChangeGender
   });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        // emptySelectionAllowed: false,
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact ),
        segments: genders.map((size) {
          return ButtonSegment(
            icon: Icon( genderIcons[ genders.indexOf(size) ] ),
            value: size, 
            label: Text(size, style: const TextStyle(fontSize: 12))
          );
        }).toList(), 
        selected: { selectedGender },
        onSelectionChanged: (newSelection) {
          FocusScope.of( context ).unfocus();
           onChangeGender( newSelection.first ); 
        
        },
      ),
    );
  }
}


class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController( viewportFraction: 0.7 ),
      children: images.isEmpty
        ? [ 
           ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover )
          ) 
        ]
        : images.map(( image ){

          late ImageProvider imageProvider;

          if ( image.startsWith('http') ) {
            imageProvider =  NetworkImage( image );
          } else {
            imageProvider = FileImage( File( image ) );
          }

          return Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10 ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage( './assets/loaders/bottle-loader.gif' ), 
                image: imageProvider
              ),
            ),
          );
      }).toList(),
    );
  }
}