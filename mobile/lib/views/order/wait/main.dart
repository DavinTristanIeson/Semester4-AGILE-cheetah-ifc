import 'dart:math';

import 'package:cheetah_mobile/components/display/orders.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
    Color color = status == OngoingOrderPhase.Finished ? Colors.green : status == OngoingOrderPhase.Cooking ? Colors.cyan : Colors.yellow;
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
                status == OngoingOrderPhase.Finished ? Icons.check : Icons.schedule,
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

  Widget buildSuccessAlert(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(GAP))
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        children: [
          const Text("Pesanan anda sudah selesai. Silahkan datang mengambil makanan anda!", style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
          )),
          const SizedBox(height: GAP_LG,),
          ElevatedButton(
            onPressed: currentTransactionKey.currentState!.refetch,
            child: const Text("Pesan lagi", style: TEXT_IMPORTANT)
          )
        ]
      ),
    );
  }

  Widget buildCancelMessage(){
    return Container(
      decoration: const BoxDecoration(
        color: COLOR_ERROR_CONTAINER,
        borderRadius: BorderRadius.all(Radius.circular(GAP)),
      ),
      child: Text(cancelMessage),
    );
  }

  @override
  void initState() {
    status = widget.current.status;
    socket!.connect();
    socket!.on("cookOrder", (_) {
      setState(() {
        status = OngoingOrderPhase.Cooking;
      });
    });
    socket!.on("finishOrder", (_) {
      setState(() {
        status = OngoingOrderPhase.Finished;
      });
    });
    socket!.on("cancelOrder", (dynamic message) {
      setState(() {
        cancelMessage = message.toString();
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
                buildCancelMessage(),
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