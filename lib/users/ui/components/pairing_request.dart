import 'package:daisy_too/types/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingRequest extends StatelessWidget {
  const PairingRequest({Key? key}) : super(key: key);
  static showModal(BuildContext context) {
    // TODO fix height
    return showModalBottomSheet(
      context: context,
      builder: (_) => const PairingRequest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 400,
        child: Card(
          child: InkWell(
            onTap: () {
              context.read<PairingProvider>().copyPairingCode();
              Navigator.of(context).pop();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _PairingCode(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Copy code',
                        style: TextStyle(fontSize: 24),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.notes),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PairingCode extends StatelessWidget {
  const _PairingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      PairingProvider.pairingCode(context),
      style: const TextStyle(fontSize: 36),
    );
  }
}
