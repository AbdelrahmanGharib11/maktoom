class ApiEndpoints {
  static const String baseUrl = 'https://api.maktom.com/v1'; // Placeholder

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';

  // Therapists
  static const String therapists = '/therapists';
  static const String therapistDetails = '/therapists/';
  static const String bookSession = '/sessions/book';

  // Journal
  static const String journalEntries = '/journal';
}
