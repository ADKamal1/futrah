String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'ERROR_INVALID_VERIFICATION_CODE':
      return 'رمز التحقق غير صحيح';
    case 'ERROR_SESSION_EXPIRED':
      return 'انتهت صلاحية رمز التحقق';
    case 'ERROR_INVALID_PHONE_NUMBER':
      return 'رقم الهاتف غير صحيح';
    case 'ERROR_QUOTA_EXCEEDED':
      return 'تم تجاوز الحد الأقصى لعمليات الارسال';
    case 'ERROR_TOO_MANY_REQUESTS':
      return 'تم تجاوز الحد الأقصى لعمليات الارسال';
    case 'ERROR_USER_DISABLED':
      return 'تم تعطيل حسابك';
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return 'تم تعطيل حسابك';
    case 'ERROR_INVALID_CREDENTIAL':
      return 'رمز التحقق غير صحيح';
    case 'user-disabled':
      return 'تم تعطيل حسابك';
    case 'ERROR_USER_TOKEN_EXPIRED':
      return 'انتهت صلاحية رمز التحقق';
    case 'ERROR_USER_NOT_FOUND':
      return 'المستخدم غير موجود';

    default:
      return 'حدث خطأ ,يرجى المحاولة مرة اخرى';
  }
}
