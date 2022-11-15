import 'package:flutter/material.dart';

class ChangeUserInfoDialog extends StatefulWidget {
  const ChangeUserInfoDialog({super.key, this.initialValue = '', this.onSave});

  final String initialValue;
  final void Function(String value)? onSave;

  @override
  State<ChangeUserInfoDialog> createState() => _ChangeUserInfoDialogState();
}

class _ChangeUserInfoDialogState extends State<ChangeUserInfoDialog> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.initialValue;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                key: const ValueKey('cancel'),
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.cancel_outlined, size: 32),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _textController,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(fontSize: 28),
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Enter something...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      key: const ValueKey('save'),
                      onPressed: () {
                        widget.onSave?.call(_textController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('SAVE'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
