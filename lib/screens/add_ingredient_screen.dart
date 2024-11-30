import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/ingredient_service.dart'; // 식재료 서비스
import '../services/ocr_service.dart'; // OCR 서비스

class AddIngredientScreen extends StatefulWidget {
  final int userId;

  const AddIngredientScreen({required this.userId, Key? key}) : super(key: key);

  @override
  _AddIngredientScreenState createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  String? selectedStorage;
  File? selectedImage;
  final OCRService ocrService = OCRService();
  final IngredientService ingredientService = IngredientService();

  Future<void> pickImageAndExtractDate() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });

      final extractedDate = await ocrService.extractExpiryDate(selectedImage!);
      if (extractedDate != null) {
        setState(() {
          expiryDateController.text = extractedDate;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OCR 실패: 유통기한을 추출할 수 없습니다.')),
        );
      }
    }
  }

  Future<void> saveIngredient() async {
    if (nameController.text.isEmpty ||
        selectedStorage == null ||
        expiryDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 필드를 입력해주세요.')),
      );
      return;
    }

    try {
      final result = await ingredientService.addIngredient(
        name: nameController.text,
        storage: selectedStorage!,
        expiryDate: expiryDateController.text,
        userId: widget.userId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );

      if (result.contains('성공적으로')) {
        Navigator.pop(context, true); // 데이터 갱신 신호
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('식재료 추가 중 오류가 발생했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false); // 데이터 갱신 신호 없이 돌아감
        return false; // 기본 뒤로가기 동작을 무시
      },
      child: Scaffold(
        appBar: AppBar(title: Text('식재료 추가')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: '식재료 이름'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedStorage,
                  decoration: InputDecoration(labelText: '보관 위치'),
                  items: ['냉장', '냉동', '실온']
                      .map((location) => DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStorage = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: expiryDateController,
                  decoration: InputDecoration(labelText: '유통기한 (YYYY-MM-DD)'),
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: pickImageAndExtractDate,
                  child: Text('갤러리에서 사진 선택 및 유통기한 추출'),
                ),
                SizedBox(height: 16),
                if (selectedImage != null)
                  Image.file(
                    selectedImage!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: saveIngredient,
                  child: Text('저장'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
