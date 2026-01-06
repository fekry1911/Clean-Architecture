class StatusCodeHandler {
  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
    // Success
      case 200:
      case 201:
        return 'تمت العملية بنجاح';

      case 400:
        return 'خطأ في البيانات المرسلة';
      case 401:
        return 'يجب تسجيل الدخول أولاً';
      case 403:
        return 'ليس لديك صلاحية للوصول';
      case 404:
        return 'البيانات المطلوبة غير موجودة';
      case 422:
        return 'البيانات المدخلة غير صحيحة';
      case 429:
        return 'تم تجاوز عدد المحاولات المسموحة';

    // Server Errors (5xx)
      case 500:
        return 'خطأ في الخادم، حاول مرة أخرى';
      case 502:
        return 'الخادم غير متاح حالياً';
      case 503:
        return 'الخدمة غير متاحة مؤقتاً';
      case 504:
        return 'انتهت مهلة الاتصال';

    // Network Errors
      case -1:
        return 'تحقق من اتصال الإنترنت';

    // Default
      default:
        return 'حدث خطأ، حاول مرة أخرى';
    }
  }

  // English version
  static String getErrorMessageEn(int statusCode) {
    switch (statusCode) {
      case 200:
      case 201:
        return 'Success';
      case 400:
        return 'Invalid request data';
      case 401:
        return 'Please login first';
      case 403:
        return 'Access forbidden';
      case 404:
        return 'Resource not found';
      case 422:
        return 'Invalid input data';
      case 429:
        return 'Too many requests';
      case 500:
        return 'Server error, please try again';
      case 502:
        return 'Server unavailable';
      case 503:
        return 'Service temporarily unavailable';
      case 504:
        return 'Request timeout';
      case -1:
        return 'Check your internet connection';
      default:
        return 'Something went wrong';
    }
  }
}