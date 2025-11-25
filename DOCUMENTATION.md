## ملخص وتحليل شامل لمشروع Hungry

هذا المستند يشرح حالة المشروع الحالية، ما يحتاجه المشروع منك كمطور أو فريق، ومجموعة توصيات مُرتَّبة بالأولوية لتحسين الجودة، الأمان، قابلية الصيانة، وعمليات النشر.

## ما الذي قمت به
- قرأت ملفات المشروع الأساسية: `pubspec.yaml`, `lib/main.dart`, `lib/root.dart`, `lib/core/network/dio_client.dart`, `lib/core/network/api_service.dart`, `lib/core/network/api_exceptions.dart`, `lib/core/utils/pref_helper.dart`, و `lib/features/auth/data/auth_repo.dart`.
- جمعت الاعتمادات، نقاط الدخول، وإعدادات الشبكة والمصادقة.

## نظرة عامة سريعة
- اسم الحزمة: huungry (من `pubspec.yaml`)
- إصدار SDK المستهدف: `^3.7.2` (Dart/Flutter)
- مكتبات بارزة: `dio ^5.9.0`, `shared_preferences`, `flutter_screenutil`, `flutter_svg`, `image_picker`, `animate_icons`.

## بنية المشروع (مختصر)
- `lib/main.dart` — نقطة الدخول؛ يستخدم `ScreenUtilInit` ويفتح `SplashView`.
- `lib/root.dart` — صفحة الجذر (Bottom Navigation + PageView).
- `lib/core/network/` — إعدادات شبكة Dio، ApiService، وApiExceptions.
- `lib/core/utils/pref_helper.dart` — مساعد لتخزين واسترجاع التوكن.
- `lib/features/auth/data/auth_repo.dart` — منطق تسجيل الدخول/التسجيل/الملف الشخصي/خروج/guest.

## نقاط مهمة تم العثور عليها (مشاكل ومواضع تحتاج انتباه)
1. ملف `lib/core/constants/api_endpoints.dart` فارغ. يفضل وضع كافة المسارات (endpoints) هناك بدلاً من كتابة السلاسل الثابتة في الكود.
2. تم hardcode لِـ `baseUrl` داخل `dio_client.dart`:

   Base URL الحالي:

   - https://sonic-zdi0.onrender.com/api

   يفضل استخدام متغير بيئي أو ملف إعدادات (flutter_dotenv أو تقسيم flavors) بدلاً من القيمة الثابتة.

3. عدم التناسق في التعامل مع Exceptions من Dio:

   - في `api_service.dart` و `api_exceptions.dart` يتم التعامل مع `DioException` (هذا صحيح مع dio v5+).
   - في `auth_repo.dart` تم استخدام `on DioError catch (e)` (DioError كانت في dio v4 وغيره؛ في dio v5 اسم الصنف تغير إلى `DioException`).

   هذا عدم تناسق سيؤدي إلى أخطاء في التجميع/التحليل (analyzer) عند استخدام dio v5. يجب تحديث جميع الأمثلة لتستخدم `DioException` أو تعديل النسخة إذا كانت تستدعي ذلك.

4. طباعة (print) مباشرة في الكود لرسائل حساسة مثل التوكنات:

   - في `dio_client.dart` و `auth_repo.dart` هناك `print(' Token for request: ${token ?? 'null'}');` وطبعات أخرى. هذا مفيد debug لكن يجب استبدالها بنظام logging مُهيأ و/أو تعطيلها في الوضع الإنتاجي.

5. تخزين التوكن في `SharedPreferences`:

   - `PrefHelper` يستخدم `SharedPreferences` لحفظ الـ token. هذا عمل سريع ومريح لكنه أقل أمانًا من `flutter_secure_storage` على البيانات الحساسة. أنصح بانتقال للتخزين الآمن إذا كان التوكن حساسًا.

6. استدعاء Endpoints كسلاسل ثابتة في `AuthRepo` مثل `'/login'`, `'/register'`، يفضل استخدام ثوابت مركزة.

7. ملف `api_exceptions.dart` يتعامل مع حالات Timeout وأنواع DioException وهو جيد لكنه يمكن توسيعه لإعادة هيكلة رسائل الخطأ الموحدة (ApiError) مع مزيد من الـ logging والـ telemetry.

8. لا يوجد ملفات إعدادات بيئية (`.env`)، لا يوجد إعدادات CI، لا توجد اختبارات (tests) مذكورة باستثناء `flutter_test` في dev_dependencies.

## المتطلبات منك (ماذا يحتاج المشروع منك الآن)
أدرج المطلوب مرتَّبًا بالأولوية مع سبب التغيير:

أ) عالي الأهمية (يمنع البناء أو أمان التطبيق)
- إصلاح عدم تناسق نوع الاستثناءات: غيّر كل `on DioError` إلى `on DioException` أو استخدم `catch (e)` ولغة توافق dio v5. هذا سيمنع أخطاء التحليل/البناء.
- تهيئة مكان للسلاسل الثابتة للـ API: املأ `lib/core/constants/api_endpoints.dart` واستخدمه في كل مكان.
- إخراج `baseUrl` من الكود: استخدم `flutter_dotenv` أو ملفات flavors. هذا مهم لتبديل بين dev/staging/prod بسهولة.

ب) متوسط الأهمية (تحسينات قابلة للصيانة)
- استبدال `SharedPreferences` بـ `flutter_secure_storage` أو على الأقل حقن طبقة تخزين يمكن تبديلها (PrefService interface).
- استبدال `print` بـ `logger` مع إدارة المستويات (debug/info/warn/error) وتعطيل الطباعة في الإنتاج.
- تحسين معالجة الأخطاء: وحد رسائل الخطأ المبينة للمستخدم (ApiError) وفر تنسيقات ثابتة.

ج) منخفض الأهمية (ميزات ونظافة الكود)
- إضافة اختبار وحدات (Unit tests) للـ `AuthRepo`, `ApiService` (باستخدام mocking)، واختبارات واجهة المستخدم البسيطة للصفحات الرئيسية.
- إضافة مستند بيئة مثال `.env.example` يوضح المتغيرات المطلوبة.
- إضافة `README.md` badges، وملف `CHANGELOG.md` بسيط.

## خطوات إعداد محلي (Prerequisites + Commands)
تأكد من تثبيت:
- Flutter SDK متوافق مع `^3.7.2`.
- Android SDK و/أو Xcode (لبناء iOS).

الأوامر (PowerShell على Windows):

```powershell
# تثبيت الحزم
flutter pub get

# تشغيل التطبيق على جهاز متصل أو محاكي
flutter run -d <device_id>

# بناء APK للإنتاج
flutter build apk --release

# تشغيل الاختبارات
flutter test
```

ملاحظات iOS: للبناء على iOS تحتاج فتح مجلد `ios/` بـ Xcode وضبط provisioning profiles وsigning.

## اقتراحات لتحسين CI/CD
- استخدم GitHub Actions أو GitLab CI مع الخطوات:
  1. checkout
  2. set up JDK / Flutter
  3. flutter pub get
  4. flutter analyze
  5. flutter test
  6. (اختياري) build apk/ipa ورفعها كأرتفاكت

- مثال بسيط لملف Actions: استخدم `subosito/flutter-action` لضبط نسخة Flutter.

## أمن & خصوصية
- لا تحفظ التوكنات في صيغ نصية قابلة للوصول (SharedPreferences) في التطبيقات التي تتطلب أمان عالي — استخدم `flutter_secure_storage`.
- تأكد من إزالة أي طبعات (print) التي تكشف توكنات أو بيانات المستخدم في الـ logs قبل الإنتاج.

## توصيات بنمط عمل/هيكلة (Developer Experience)
- أدخل DI بسيطة مثل `get_it` أو استخدم Provider/Riverpod لحقن `AuthRepo`, `ApiService` لكي يسهل اختبار المكونات.
- فصل طبقات: presentation / domain / data (إذا رغبت بمزيد من التنظيم).
- أضف مستند CONTRIBUTING.md يشرح قواعد البرمجة، فلو/format، وgit workflow.

## قائمة تحقق سريعة (عمل فوري — 30–120 دقيقة)
1. استبدال `DioError` بـ `DioException` في `auth_repo.dart` (وغيرها) — يجب أن يكون هذا أول عمل.
2. ملء `api_endpoints.dart` بثوابت نقاط النهاية المستعملة (`login`, `register`, `profile`, `update-profile`, `logout`, ...).
3. استبدال `baseUrl` في `dio_client.dart` بإدخال من `.env` أو ملف config.
4. تشغيل `flutter analyze` و `flutter test` وإصلاح أي أخطاء تحليلية.

## أمثلة سريعة للتغييرات المقترحة (ملاحظة: أمثلة، لا تغيير فعلي هنا)
- تغيير catch في `auth_repo.dart`:

```dart
// قد تحتاج لتعديل من
// on DioError catch (e) { ... }

// إلى
on DioException catch (e) {
  throw ApiExceptions.handleError(e);
}
```

- استخدام env في `dio_client.dart` (فكرة):

```dart
// باستخدام flutter_dotenv
final baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://...';
```

## ما الذي أحتاجه منك حتى أكمِل أو أطبّق التغييرات؟
1. هل تريد أن أقوم بتطبيق التغييرات الحرجة (استبدال DioError، تعبئة api_endpoints، إخراج baseUrl إلى env) مباشرة في المستودع؟
2. هل هناك بيئات (dev/staging/prod) وURLs رسمية تود وضعها في `.env` أو ملف إعدادات؟
3. هل تفضّل استخدام `flutter_secure_storage` الآن أم نؤجلها للمرحلة القادمة؟

## خاتمة وسير العمل المقترح
- الخطوة الأولى: إصلاح أخطاء التوافق مع dio v5 (DioException) وتمكين المشروع من التحليل والبناء محليًا.
- الخطوة الثانية: فصل إعدادات البيئة (baseUrl و API keys) ووضع ثوابت Endpoints.
- بعد ذلك: تحسين الأمن، اختبارات آلية، إعداد CI.

إذا رغبت، أبدأ فورًا في تنفيذ التغييرات الحرجة (أقوم بتعديل الملفات اللازمة وتشغيل `flutter analyze` و `flutter test`). قل لي أي تغيير تريد البدء به الآن.

---
وثيقة أنشئت تلقائيًا بتاريخ: 2025-10-22
