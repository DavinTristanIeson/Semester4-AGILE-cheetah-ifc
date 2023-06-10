import 'dart:math';

import 'package:cheetah_mobile/components/display/orders.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/model.dart';
import '../../../requests/setup.dart';

class WaitView extends StatefulWidget {
  final MenuTransaction current;
  const WaitView(this.current, {super.key});

  @override
  State<WaitView> createState() => _WaitViewState();
}

class _WaitViewState extends State<WaitView> with SingleTickerProviderStateMixin {
  late OngoingOrderPhase status;
  String cancelMessage = "";
  late AnimationController _iconAnimation;

  Widget buildIcon(BuildContext context){
    Color color;
    IconData icon;
    switch (status){
      case OngoingOrderPhase.Pending:
        color = Colors.yellow;
        icon = Icons.schedule;
        break;
      case OngoingOrderPhase.Cooking:
        color = Colors.cyan;
        icon = Icons.schedule;
        break;
      case OngoingOrderPhase.Finished:
        color = Colors.green;
        icon = Icons.check;
        break;
      case OngoingOrderPhase.Canceled:
        color = COLOR_ERROR;
        icon = Icons.cancel;
        break;
    }
    return Column(
      children: [
        AnimatedBuilder(
          animation: _iconAnimation,
          builder: (_, __) => Transform.scale(
            scale: _iconAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(150.0),
              ),
              child: Icon(
                icon,
                color: color,
                size: min(300, MediaQuery.of(context).size.width * 0.8),
              ),
            ),
          ),
        ),
        Text(status.stringify(), style: TextStyle(color: color, fontSize: FS_LARGE, fontWeight: FontWeight.bold)),
      ]
    );
  }

  Widget buildAlertContainer(Widget child, Color color){
    return Container(
      width: min(600, MediaQuery.of(context).size.width * 0.8),
      margin: const EdgeInsets.only(top: GAP_LG),
      padding: const EdgeInsets.all(GAP_LG),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(GAP)),
      ),
      child: child,
    );
  }

  Widget buildSuccessAlert(){
    return buildAlertContainer(
      Column(
        children: [
          const Text("Pesanan anda sudah selesai. Silahkan datang mengambil makanan anda!", style: TEXT_SEMIBOLD),
          const SizedBox(height: GAP_LG,),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: currentTransactionKey.currentState!.refetch,
              child: const Text("PESAN LAGI", style: TEXT_LINK)
            )
          )
        ]
      ), COLOR_SUCCESS_CONTAINER
    );
  }

  Widget buildCancelMessage(BuildContext context){
    return buildAlertContainer(
      Column(
        children: [
          const Text("Alasan Pembatalan", style: TEXT_ITEM_TITLE),
          Text(cancelMessage, style: TEXT_DEFAULT),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: currentTransactionKey.currentState!.refetch,
              child: const Text("PESAN LAGI", style: TEXT_LINK)
            )
          )
        ]
      ), COLOR_ERROR_CONTAINER
    );
  }

  @override
  void initState() {
    status = widget.current.status;
    socket!.connect();
    socket!.on("cookOrder", (data) {
      if (int.tryParse(data) == widget.current.id){
        setState(() {
          status = OngoingOrderPhase.Cooking;
        });
      }
    });
    socket!.on("finishOrder", (data) {
      if (int.tryParse(data) == widget.current.id){
        setState(() {
          status = OngoingOrderPhase.Finished;
        });
      }
    });
    socket!.on("cancelOrder", (data) {
      if (int.tryParse(data[0]) == widget.current.id)
        setState(() {
          status = OngoingOrderPhase.Canceled;
          cancelMessage = data[1].toString();
        });
    });
    _iconAnimation = AnimationController(
      duration: const Duration(seconds: 2),
      animationBehavior: AnimationBehavior.preserve,
      lowerBound: 0.95,
      upperBound: 1.05,
      vsync: this,
    )
    ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    socket!.off("cookOrder");
    socket!.off("cancelOrder");
    socket!.off("finishOrder");
    socket!.disconnect();
    _iconAnimation.dispose();
    super.dispose();
  }

  Widget buildOrderList(BuildContext context){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.current.records.length,
      itemBuilder: (context, idx) {
        return OrderRecordListTile(item: widget.current.records[idx]);
      }
    );
  }

  Widget buildTotal(){
    return Container(
      decoration: const BoxDecoration(
        color: COLOR_BRIGHT,
      ),
      padding: const EdgeInsets.symmetric(horizontal: GAP, vertical: GAP_LG),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: "Total: ", style: TEXT_SEMIBOLD),
            TextSpan(text: widget.current.hargaTotal, style: TEXT_DETAIL),
          ]
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              buildIcon(context),
              if (status == OngoingOrderPhase.Finished)
                buildSuccessAlert(),
              if (status == OngoingOrderPhase.Canceled)
                buildCancelMessage(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GAP, vertical: GAP_LG),
                child: buildOrderList(context)
              ),
              const SizedBox(height: 48.0),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          width: double.maxFinite,
          child: buildTotal()
        ),
      ]
    );
  }
}