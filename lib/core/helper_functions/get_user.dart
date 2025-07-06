import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth
import '../../constants.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/entites/user_entity.dart';
import '../services/shared_preferences_singleton.dart';

UserEntity getUser() {
  try {
    // 1. محاولة الحصول على بيانات المستخدم المسجل
    final currentUser = FirebaseAuth.instance.currentUser;

    // 2. إذا كان المستخدم مسجلاً عبر جوجل
    if (currentUser != null) {
      return UserModel(
        name: currentUser.displayName ?? currentUser.email?.split('@').first ?? 'مستخدم جديد',
        email: currentUser.email ?? '',
        uId: currentUser.uid,
      );
    }

    // 3. إذا لم يكن مسجلاً، جرب قراءة البيانات المحفوظة
    final jsonString = Prefs.getString(kUserData);
    if (jsonString == null || jsonString.isEmpty) {
      throw Exception('لا توجد بيانات مستخدم');
    }

    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    if (jsonData['uId'] == null) {
      throw FormatException('حقل uId مطلوب');
    }

    return UserModel.fromJson(jsonData);

  } catch (e, stackTrace) {
    print('''
    خطأ في قراءة بيانات المستخدم:
    الخطأ: $e
    مسار التنفيذ: $stackTrace
    ''');

    // 4. العودة إلى بيانات جوجل إذا كانت متاحة
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return UserModel(
        name: currentUser.displayName ?? currentUser.email?.split('@').first ?? 'مستخدم جديد',
        email: currentUser.email ?? '',
        uId: currentUser.uid,
      );
    }

    // 5. إذا فشل كل شيء، إرجاع مستخدم ضيف
    return UserModel(
      name: 'مستخدم جديد',
      email: '',
      uId: 'guest_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}