import 'package:flutter/material.dart';
import 'package:tictactoebetclic/src/presentation/widgets/brightness_button_widget.dart';

class InitializationPage extends StatelessWidget {
  const InitializationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tic Tac Toe'),
        actions: const [BrightnessButton()],
      ),
      body: const Center(
        child: Text('You have pushed the button this many times:'),
      ),
    );
  }
}
