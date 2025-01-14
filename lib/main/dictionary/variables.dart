bool isLoading = false;
bool isspeaking = false;
String code = 'bn';
double volume = 0.5;
double pitch = 1.0;
double rate = 0.5;

// ignore: unused_element
bool _istranslate = false;
// Future<String> translate(String text, String code) async {
//   try {
//     var translation = await translator.translate(text, from: 'en', to: code);
//     // setState(() {
//     _istranslate = true;
//     //});
//     return translation.text.toString();
//   } catch (error) {
//     //setState(() {
//     _istranslate = false;
//     //});
//     return 'unable to transtate';
//   }
// }

final Map<String, String> languagesMap = {
  'af': 'Afrikaans',
  'am': 'Amharic',
  'ar': 'Arabic',
  'as': 'Assamese',
  'az': 'Azerbaijani',
  'be': 'Belarusian',
  'bg': 'Bulgarian',
  'bn': 'Bengali Bangla',
  'bs': 'Bosnian',
  'ca': 'Catalan Valencian',
  'cs': 'Czech',
  'cy': 'Welsh',
  'da': 'Danish',
  'de': 'German',
  'el': 'Modern Greek',
  'en': 'English',
  'es': 'Spanish Castilian',
  'et': 'Estonian',
  'eu': 'Basque',
  'fa': 'Persian',
  'fi': 'Finnish',
  'fil': 'Filipino Pilipino',
  'fr': 'French',
  'gl': 'Galician',
  'gsw': 'Swiss German Alemannic Alsatian',
  'gu': 'Gujarati',
  'he': 'Hebrew',
  'hi': 'Hindi',
  'hr': 'Croatian',
  'hu': 'Hungarian',
  'hy': 'Armenian',
  'id': 'Indonesian',
  'is': 'Icelandic',
  'it': 'Italian',
  'ja': 'Japanese',
  'ka': 'Georgian',
  'kk': 'Kazakh',
  'km': 'Khmer Central Khmer',
  'kn': 'Kannada',
  'ko': 'Korean',
  'ky': 'Kirghiz Kyrgyz',
  'lo': 'Lao',
  'lt': 'Lithuanian',
  'lv': 'Latvian',
  'mk': 'Macedonian',
  'ml': 'Malayalam',
  'mn': 'Mongolian',
  'mr': 'Marathi',
  'ms': 'Malay',
  'my': 'Burmese',
  'nb': 'Norwegian Bokmål',
  'ne': 'Nepali',
  'nl': 'Dutch Flemish',
  'no': 'Norwegian',
  'or': 'Oriya',
  'pa': 'Panjabi Punjabi',
  'pl': 'Polish',
  'ps': 'Pushto Pashto',
  'pt': 'Portuguese',
  'ro': 'Romanian Moldavian Moldovan',
  'ru': 'Russian',
  'si': 'Sinhala Sinhalese',
  'sk': 'Slovak',
  'sl': 'Slovenian',
  'sq': 'Albanian',
  'sr': 'Serbian',
  'sv': 'Swedish',
  'sw': 'Swahili',
  'ta': 'Tamil',
  'te': 'Telugu',
  'th': 'Thai',
  'tl': 'Tagalog',
  'tr': 'Turkish',
  'uk': 'Ukrainian',
  'ur': 'Urdu',
  'uz': 'Uzbek',
  'vi': 'Vietnamese',
  'zh': 'Chinese',
  'zu': 'Zulu',
};
