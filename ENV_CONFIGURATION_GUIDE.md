# 📋 Environment Configuration Guide

**النسخة:** 1.0.0  
**آخر تحديث:** نوفمبر 2025

---

## 📚 نظرة عامة

ملفات البيئة (.env) تحتوي على جميع الإعدادات والمفاتيح الحساسة التي يحتاجها التطبيق للعمل. يتم تحميل هذه الإعدادات عند بدء التطبيق باستخدام مكتبة `flutter_dotenv`.

---

## 📁 ملفات البيئة

### `.env.example`
- **الغرض:** نموذج توثيقي يعرض جميع المتغيرات المتاحة
- **من يراه:** الجميع (مشمول في Git)
- **المحتوى:** قيم افتراضية وتعليقات توضيحية

### `.env` (التطوير)
- **الغرض:** الإعدادات الفعلية لبيئة التطوير
- **من يراه:** فريق التطوير فقط
- **المحتوى:** قيم حقيقية للـ APIs والمفاتيح
- **الأمان:** ⚠️ لا تضفه إلى Git!

### `.env.production` (الإنتاج)
- **الغرض:** الإعدادات الفعلية لبيئة الإنتاج
- **من يراه:** فريق العمليات فقط
- **المحتوى:** قيم الإنتاج الحقيقية
- **الأمان:** ⚠️ لا تضفه إلى Git!

### `.env.staging` (الاختبار)
- **الغرض:** الإعدادات للبيئة المرحلية
- **من يراه:** فريق QA والمطورين
- **المحتوى:** قيم بيئة الاختبار
- **الأمان:** ⚠️ لا تضفه إلى Git!

---

## 🔧 متغيرات البيئة

### 1. API Configuration

```env
# API Base URL - الرابط الأساسي للـ API
API_BASE_URL=https://sonic-zdi0.onrender.com/api

# API Timeout - المدة الزمنية بالثواني قبل انتهاء الطلب
API_TIMEOUT=30

# API Retry Count - عدد محاولات إعادة الطلب عند الفشل
API_RETRY_COUNT=3
```

**الاستخدام:**
```dart
// في dio_client.dart
final baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://sonic-zdi0.onrender.com/api';
final timeout = int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30') ?? 30;
```

---

### 2. Authentication Configuration

```env
# Default Login Email - البريد الإلكتروني الافتراضي (للاختبار فقط)
DEFAULT_LOGIN_EMAIL=test@example.com

# Default Login Password - كلمة المرور الافتراضية (للاختبار فقط)
DEFAULT_LOGIN_PASSWORD=password123

# Token Storage Key - مفتاح تخزين التوكن في SharedPreferences
TOKEN_STORAGE_KEY=auth_token
```

**ملاحظات الأمان:**
- ⚠️ لا تضع كلمات مرور حقيقية في .env
- ⚠️ استخدم للاختبار فقط
- ⚠️ في الإنتاج اترك القيم فارغة

---

### 3. App Configuration

```env
# App Name - اسم التطبيق
APP_NAME=Hungry

# App Version - رقم إصدار التطبيق (Semantic Versioning)
APP_VERSION=1.0.0

# Build Number - رقم البناء (يزداد مع كل بناء)
BUILD_NUMBER=1
```

---

### 4. Feature Flags

```env
# Enable Debug Mode - تفعيل وضع التصحيح
# Values: true/false
ENABLE_DEBUG_MODE=true

# Enable Analytics - تفعيل تحليل السلوك
# Values: true/false
ENABLE_ANALYTICS=false

# Enable Crash Reports - تفعيل تقارير الأعطال
# Values: true/false
ENABLE_CRASH_REPORTS=false
```

**الاستخدام:**
```dart
bool isDebugMode = dotenv.env['ENABLE_DEBUG_MODE']?.toLowerCase() == 'true';
if (isDebugMode) {
  print('Debug mode enabled');
}
```

---

### 5. Payment Configuration (المستقبل)

```env
# Stripe Public Key
STRIPE_PUBLIC_KEY=pk_test_xxxxxxxxxxxxxxxxxxxxx

# PayPal Client ID
PAYPAL_CLIENT_ID=client_id_xxxxxxxxxxxxx
```

---

### 6. Firebase Configuration (المستقبل)

```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
FIREBASE_APP_ID=your-app-id
```

---

### 7. Google Maps Configuration (المستقبل)

```env
GOOGLE_MAPS_API_KEY=your-maps-api-key
```

---

### 8. Logging Configuration

```env
# Log Level - مستوى السجلات المعروضة
# Values: debug, info, warning, error
LOG_LEVEL=debug

# Enable Network Request Logging - تسجيل طلبات الشبكة
# Values: true/false
ENABLE_NETWORK_LOGGING=true
```

---

### 9. Cache Configuration

```env
# Cache Duration - مدة الـ Cache بالدقائق
CACHE_DURATION=15

# Enable Cache - تفعيل الـ Cache
# Values: true/false
ENABLE_CACHE=true
```

---

### 10. Device/Environment Specific

```env
# Current Environment
# Values: development, staging, production
ENVIRONMENT=development

# Device Platform
# Values: android, ios, web, windows
PLATFORM=
```

---

## 📥 التثبيت والإعداد

### الخطوة 1: نسخ الملف

```bash
# في Windows (PowerShell)
Copy-Item .env.example .env

# في Mac/Linux
cp .env.example .env
```

### الخطوة 2: تحرير .env

أفتح الملف وأدخل القيم الفعلية:

```env
API_BASE_URL=https://your-api.com/api
STRIPE_PUBLIC_KEY=pk_live_xxxxxxxxxxxxx
# إلخ...
```

### الخطوة 3: التحقق من التحميل

في `lib/main.dart` سيتم تحميل الملف تلقائياً:

```dart
await dotenv.load();
```

---

## 🔐 إرشادات الأمان

### ✅ افعل:
1. ✅ أضف `.env` إلى `.gitignore`
2. ✅ استخدم ملفات بيئة منفصلة لكل بيئة
3. ✅ احم المفاتيح الحساسة بشكل صحيح
4. ✅ استخدم Services Vaults للإنتاج
5. ✅ دوّر المفاتيح والأسرار بانتظام

### ❌ لا تفعل:
1. ❌ لا تضع .env في Git
2. ❌ لا تشارك .env مع أحد
3. ❌ لا تضع كلمات مرور حقيقية
4. ❌ لا تستخدم نفس المفاتيح في جميع البيئات
5. ❌ لا تضع مفاتيح سرية في الكود

---

## 📝 اختبار الإعدادات

### التحقق من التحميل:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  // تحميل البيئة
  dotenv.load();
  
  // اختبار القراءة
  print('API URL: ${dotenv.env['API_BASE_URL']}');
  print('Environment: ${dotenv.env['ENVIRONMENT']}');
  
  runApp(MyApp());
}
```

### التصحيح:

إذا لم يتم تحميل الملف:
```dart
try {
  await dotenv.load();
  print('✅ .env loaded successfully');
} catch (e) {
  print('❌ Error loading .env: $e');
}
```

---

## 🔄 ملفات البيئة المختلفة

### Structure (الهيكل الموصى به):

```
project/
├── .env                 # التطوير (لا تضفها إلى Git)
├── .env.example         # النموذج (في Git)
├── .env.production      # الإنتاج (لا تضفها إلى Git)
├── .env.staging         # الاختبار (لا تضفها إلى Git)
└── .gitignore          # يجب أن يحتوي على .env*
```

### .gitignore:

```gitignore
# Environment variables
.env
.env.local
.env.production
.env.staging
.env.*.local
```

---

## 🚀 الاستخدام في الكود

### الطريقة الأساسية:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

// في أي مكان في التطبيق
String apiUrl = dotenv.env['API_BASE_URL'] ?? 'default-value';
bool isDebug = dotenv.env['ENABLE_DEBUG_MODE']?.toLowerCase() == 'true';
int timeout = int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30') ?? 30;
```

### في DioClient:

```dart
class DioClient {
  final Dio _dio = Dio();
  
  DioClient() {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://sonic-zdi0.onrender.com/api';
    final timeout = int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30') ?? 30;
    
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: timeout),
      receiveTimeout: Duration(seconds: timeout),
    );
  }
}
```

---

## 🛠️ الخطوات التالية

### قادم قريباً:
- [ ] إضافة دعم متعدد البيئات (prod, staging, dev)
- [ ] إضافة تشفير للقيم الحساسة
- [ ] إضافة Secrets Management Service
- [ ] دعم متغيرات البيئة من الجهاز

---

## 📞 المساعدة والدعم

### المشاكل الشائعة:

**المشكلة:** `FileNotFoundError` عند تحميل .env
```
الحل: تأكد من أن ملف .env موجود في جذر المشروع
```

**المشكلة:** لا تقرأ القيم الجديدة
```
الحل: أعد تشغيل التطبيق (flutter run) بدل hot reload
```

**المشكلة:** قيم فارغة في البيئة
```
الحل: تحقق من صيغة الملف وأن القيمة موضوعة بشكل صحيح
```

---

**آخر تحديث:** نوفمبر 2025  
**الإصدار:** 1.0.0  
**الحالة:** ✅ مكتمل
