import 'package:flutter/material.dart';

import '../display/info.dart';

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
  State<FetchWrapper<T>> createState() => FetchWrapperState<T>();
}

class FetchWrapperState<T> extends State<FetchWrapper<T>> {
  late Future<T> future;

  @override
  void initState() {
    future = widget.fetch();
    super.initState();
  }

  Future<T> refetch() async {
    Future<T> result = widget.fetch();
    setState(() {
      future = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot<T> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return widget.emptyComponent ??
                  EmptyComponent(
                    child: widget.retryWidget != null
                        ? widget.retryWidget!(refetch)
                        : null,
                  );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return widget.loadingComponent ?? const LoadingComponent();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return widget.errorComponent ??
                    ErrorComponent(
                      reason: snapshot.error.toString(),
                      child: widget.retryWidget != null
                          ? widget.retryWidget!(refetch)
                          : null,
                    );
              }
              if (snapshot.hasData) {
                return widget.builder(context, snapshot.data as T);
              } else {
                return widget.emptyComponent ??
                    EmptyComponent(
                      child: widget.retryWidget != null
                          ? widget.retryWidget!(refetch)
                          : null,
                    );
              }
          }
        });
  }
}