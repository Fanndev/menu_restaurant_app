import 'package:flutter/material.dart';

enum PopupType { success, error, warning, comingsoon }

class Popup extends StatelessWidget {
  const Popup({super.key, required this.popupType});
  final PopupType popupType;

  Future show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => build(context),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                        popupType == PopupType.success
                            ? Icons.check_circle
                            : popupType == PopupType.error
                                ? Icons.error
                                : popupType == PopupType.warning
                                    ? Icons.warning
                                    : Icons.info,
                        color: popupType == PopupType.success
                            ? Colors.green
                            : popupType == PopupType.error
                                ? Colors.red
                                : popupType == PopupType.warning
                                    ? Colors.orange
                                    : Colors.blue,
                        size: 50),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      popupType == PopupType.success
                          ? "Successfully"
                          : popupType == PopupType.error
                              ? "Failed add new menu"
                              : popupType == PopupType.warning
                                  ? "Something went wrong"
                                  : 'Coming Soon',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
