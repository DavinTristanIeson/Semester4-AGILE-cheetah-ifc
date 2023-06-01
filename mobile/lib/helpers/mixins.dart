import 'package:flutter/material.dart';

mixin SnackbarMessenger {
  void sendMessage(BuildContext context, String message){
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }
  void sendError(BuildContext context, String message){
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(
      content: Text(message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
        )
      ),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
    ));
  }
}