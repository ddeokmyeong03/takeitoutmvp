import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OCRService {
  final String apiUrl = 'http://127.0.0.1:5000/process-image'; // Python 서버 주소

  Future<String?> extractExpiryDate(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);
        return data['expiry_date'];
      } else {
        print('OCR 실패: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('OCR API 호출 오류: $e');
      return null;
    }
  }
}
