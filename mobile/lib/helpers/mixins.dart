import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin SnackbarMessenger {
  void sendMessage(BuildContext context, String message){
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messenger.showSnackBar(SnackBar(content: Text(message)));
    });
  }
  void sendError(BuildContext context, String message){
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messenger.showSnackBar(SnackBar(
        content: Text(message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontWeight: FontWeight.bold,
          )
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ));
    });
  }
}