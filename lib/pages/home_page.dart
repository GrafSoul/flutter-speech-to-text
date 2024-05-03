import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speech_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpeechController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Speech Demo', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text(
                  controller.isListening.value
                      ? "Listening..."
                      : controller.speechEnabled.value
                          ? "Tap the microphone to start listening..."
                          : "Speech not available",
                  style: const TextStyle(fontSize: 20),
                )),
            Obx(() => Text(
                  controller.wordsSpoken.value,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                )),
            Obx(() => Visibility(
                  visible: controller.speechToText.isNotListening && controller.confidenceLevel.value > 0,
                  child: Text(
                    "Confidence: ${(controller.confidenceLevel.value * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: () {
              if (controller.isListening.value) {
                controller.stopListening();
              } else {
                controller.startListening();
              }
            },
            tooltip: 'Listen',
            backgroundColor: Colors.red,
            child: Icon(
              controller.isListening.value ? Icons.mic : Icons.mic_off,
              color: Colors.white,
            ),
          )),
    );
  }
}
