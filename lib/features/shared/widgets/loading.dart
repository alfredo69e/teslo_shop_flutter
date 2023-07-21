part of'./../../features.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator( strokeWidth: 2, ),
      ),
    );
  }
}