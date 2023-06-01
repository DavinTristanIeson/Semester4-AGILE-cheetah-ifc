import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

class FetchWrapper<T> extends StatefulWidget {
  final Future<T> Function() fetch;
  final Widget Function(BuildContext, T) builder;
  final Widget? errorComponent;
  final Widget? loadingComponent;
  final Widget? emptyComponent;
  // The fetch function will be passed to the widget
  final Widget Function(Future<T> Function())? retryWidget;
  const FetchWrapper({
    super.key,
    required this.fetch,
    required this.builder,
    this.errorComponent,
    this.emptyComponent,
    this.loadingComponent,
    this.retryWidget,
  });

  @override
  State<FetchWrapper<T>> createState() => _FetchWrapperState<T>();
}

class _FetchWrapperState<T> extends State<FetchWrapper<T>> {
  late Future<T> future;

  @override
  void initState() {
    future = widget.fetch();
    super.initState();
  }
  Future<T> refetch() async {
    Future<T> result = widget.fetch();
    setState(() => {future = result});
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.none:
            return widget.emptyComponent ?? EmptyComponent(
              child: widget.retryWidget != null ? widget.retryWidget!(refetch) : null,
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return widget.loadingComponent ?? const LoadingComponent();
          case ConnectionState.done:
            if (snapshot.hasError){
              return widget.errorComponent ?? ErrorComponent(
                reason: snapshot.error.toString(),
                child: widget.retryWidget != null ? widget.retryWidget!(refetch) : null,
              );
            }
            if (snapshot.hasData){
              return widget.builder(context, snapshot.data as T);
            } else {
              return widget.emptyComponent ?? EmptyComponent(
                child: widget.retryWidget != null ? widget.retryWidget!(refetch) : null,
              );
            }
        }
      }
    );
  }
}

class EmptyComponent extends StatelessWidget {
  final Widget? child;
  const EmptyComponent({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Theme.of(context).colorScheme.tertiary,
              size: 48,
            ),
            Text(NO_DATA, textAlign: TextAlign.center, style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.bold,
              fontFamily: "Josefin Sans",
              fontSize: 18,
            )),
            const SizedBox(height: 16),
            if (child != null)
              child!,
          ]
        ),
      ),
    );
  }
}

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.loose(const Size.square(100.0)),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator()
      ),
    );
  }
}

class ErrorComponent extends StatelessWidget {
  final String? reason;
  final Widget? child;
  const ErrorComponent({super.key, this.reason, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            Text(UNEXPECTED_ERROR, style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.bold,
              fontFamily: "Josefin Sans",
              fontSize: 18
            )),
            if (reason != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(reason!, style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontFamily: "Josefin Sans",
                  fontSize: 16
                )),
              ),
            if (child != null)
              child!
          ]
        ),
      ),
    );
  }
}