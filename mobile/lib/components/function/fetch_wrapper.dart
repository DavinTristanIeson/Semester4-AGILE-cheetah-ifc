import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

class FetchWrapper<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext, T?) builder;
  final Widget? errorComponent;
  final Widget? loadingComponent;
  final Widget? emptyComponent;
  const FetchWrapper({
    super.key,
    required this.future,
    required this.builder,
    this.errorComponent,
    this.emptyComponent,
    this.loadingComponent,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.none:
            return emptyComponent ?? const EmptyComponent();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return loadingComponent ?? const LoadingComponent();
          case ConnectionState.done:
            if (snapshot.hasError){
              return errorComponent ?? const ErrorComponent();
            }
            if (snapshot.hasData){
              return builder(context, snapshot.data);
            } else {
              return emptyComponent ?? const EmptyComponent();
            }
        }
      }
    );
  }
}

class EmptyComponent extends StatelessWidget {
  const EmptyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Nothing here");
  }
}

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
        ),
        child: const Text(UNEXPECTED_ERROR)
      )
    );
  }
}