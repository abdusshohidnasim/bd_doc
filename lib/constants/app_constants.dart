final class AppRegExpText {
  AppRegExpText._();
// Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
          "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}

// Keys
const String kKeyfirstTime = "first";
const String kSelectedCategotyId = "selectedCategotyId";
const String kKeyStatus = 'status';
const String kEmail = 'email';
const String kPassword = 'password';
const String kMediaFile = 'media_files';
const String kIsFav = 'IsFav';

//old

const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyIsOnboardingCompleted = 'is_onboarding_completed';
const String kKeyAccessToken = 'access_token';
const String kkeyrefreshToken = 'refresh_token';
const String kPhone = 'phone_number';
const String kKeySelectedLocation = 'selected_location';
const String kKeySelectedLat = 'selected_lot';
const String kKeySelectedLng = 'selected_lng';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'language_code';
const String kKeyDeviceToken = 'device_token';
const String kKeyUser = 'user';

const String kKeyProvider = 'provider';
const String kFacebook = 'facebook';
const String kApple = 'apple';
const String kGoogle = 'google';
const String kKeyEnglish = 'en';
const String kKeyPortuguese = 'pt';

const String kKeyFirstName = 'first_name';
const String kKeyLastName = 'lst_name';
const String kKeyDeviceID = 'device_id';
const String kKeyUserID = 'user_id';

const String kKeyIsExploring = 'exploring';
//kKeyFCMToken
const String kKeyFCMToken = 'firebase_token';
//order statuses

const String fallBackImage =
    "https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60";

const String imageback =
    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";
