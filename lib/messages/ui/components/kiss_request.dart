import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:daisy_too/messages/ui/components/kiss_tap.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KissRequest extends StatefulWidget {
  const KissRequest({Key? key}) : super(key: key);

  @override
  State<KissRequest> createState() => _KissRequestState();
}

class _KissRequestState extends State<KissRequest> {
  final _controller = TextEditingController();

  _sendRequest(BuildContext context) {
    final request = Kiss.fromRequest(_controller.value.text);
    context.read<KissProvider>().sendKiss(request);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Material(
                      child: Image.asset('assets/kisses/request.png'),
                    ),
                  ),
                  KissTap(onTap: () => _sendRequest(context)),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Request kiss here',
                ),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}