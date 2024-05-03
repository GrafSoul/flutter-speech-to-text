import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechController extends GetxController {
  final SpeechToText speechToText = SpeechToText();
  var speechEnabled = false.obs;
  var wordsSpoken = "".obs;
  var confidenceLevel = 0.0.obs;
  var isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
  }

  @override
  void onClose() {
    speechToText.stop();
    super.onClose();
  }

  void onStatusChanged(String status) {
    isListening.value = status == 'listening';
    speechEnabled.value = speechToText.isAvailable;
    update();
  }

  void initSpeech() async {
    speechEnabled.value = await speechToText.initialize();
  }

  void startListening() async {
    if (!isListening.value) {
      isListening.value = true;
      await speechToText.listen(
        onResult: onSpeechResult,
        localeId: 'ru_RU',
      );
      confidenceLevel.value = 0;
    }
    update();
  }

  void stopListening() async {
    if (isListening.value) {
      await speechToText.stop();
      isListening.value = false;
      speechEnabled.value = false;
    }
    update();
  }

  void onSpeechResult(result) {
    wordsSpoken.value = result.recognizedWords;
    confidenceLevel.value = result.confidence;
  }
}
