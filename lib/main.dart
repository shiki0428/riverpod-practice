import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animationFlagProvider = StateProvider((ref) => false);
final animationParamaterProvider = StateProvider((ref) => 0);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationTest(),
    );
  }
}

class AnimationTest extends ConsumerWidget {
  const AnimationTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            height: 400,
            child: Stack(
              children: <Widget>[
                Positioned(
                  width: 50.0,
                  height: 50.0,
                  left: 100 *
                          cos(4 *
                              ref
                                  .watch(animationParamaterProvider.notifier)
                                  .state *
                              pi /
                              180) +
                      200,
                  top: 100 *
                          sin(4 *
                              ref
                                  .watch(animationParamaterProvider.notifier)
                                  .state *
                              pi /
                              180) +
                      200,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  width: 50.0,
                  height: 50.0,
                  left: 100 *
                          cos(5 *
                              ref
                                  .watch(animationParamaterProvider.notifier)
                                  .state *
                              pi /
                              180) +
                      200,
                  top: 100 *
                          sin(5 *
                              ref
                                  .watch(animationParamaterProvider.notifier)
                                  .state *
                              pi /
                              180) +
                      200,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 200),
            child: ElevatedButton(
              onPressed: () async {
                print(ref.read(animationFlagProvider.notifier).state);
                ref.read(animationFlagProvider.notifier).state =
                    !ref.watch(animationFlagProvider.notifier).state;
                while (ref.watch(animationFlagProvider.notifier).state) {
                  //print(1);
                  ref.watch(animationParamaterProvider);
                  ref.watch(animationParamaterProvider.notifier).state++;
                  await Future.delayed(Duration(milliseconds: 1));
                }
              },
              child: Container(
                color: Colors.blue,
                child: const Center(child: Text('Tap me')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
