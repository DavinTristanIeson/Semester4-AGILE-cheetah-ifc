import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class EmptyComponent extends StatelessWidget {
  final Widget? child;
  const EmptyComponent({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(GAP_LG),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.warning,
            color: Theme.of(context).colorScheme.tertiary,
            size: 48,
          ),
          Text(NO_DATA,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
                fontFamily: "Josefin Sans",
                fontSize: 18,
              )),
          const SizedBox(height: 16),
          if (child != null) child!,
        ]),
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
          padding: const EdgeInsets.all(GAP_LG),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.black.withOpacity(0.5),
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator()),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String reason;
  final Widget? child;
  const ErrorMessage({super.key, required this.reason, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(GAP_LG),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
        ),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: GAP_LG),
            child: Text(reason,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontFamily: "Josefin Sans",
                    fontSize: 16)),
          ),
          if (child != null) child!
        ]),
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
        padding: const EdgeInsets.all(GAP_LG),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          Text(UNEXPECTED_ERROR,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Josefin Sans",
                  fontSize: 18)),
          if (reason != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: GAP_LG),
              child: Text(reason!,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontFamily: "Josefin Sans",
                      fontSize: 16)),
            ),
          if (child != null) child!
        ]),
      ),
    );
  }
}
