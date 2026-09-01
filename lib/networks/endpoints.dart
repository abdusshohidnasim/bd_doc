// ignore_for_file: constant_identifier_names
const String url = "https://waredrobebestie.softvencealpha.com/api/v1/";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  //auth
  static String signUp() => "account/signup/";
  static String verificationEmail() => "account/verify-token/";
  static String logIn() => "account/login/";
  static String resetPassword() => "account/forget-password/";
  static String newpasswordsatap() => "account/reset-password/";
  static String resendCode() => "account/resend-token/";
  static String getProfile() => "account/profile/";
  static String refreshToken() => "account/refresh/";
  static String logout() => "account/logout/";
  static String changePassword() => "account/change-password/";

  // onbording
  static String onbording() => "preferences/";
  static String setPreferences() => "account/set-preferences/";
  static String getMyOnbording() => "account/my-preferences/";

  ///profile
  static String profile() => "/user/profile";
  static String changeName() => "account/profile/";
  static String changePhoto() => "account/profile/avatar/";
  static String deleteProfile() => "account/delete/";

  // static String getShopByCategories(String slug) =>
  //     "/api/shop-categories/$slug/";

  // closet
  static String getClosetCategories() => "categories/";
  static String closetItems() => "closet/";
  static String closetItemDetails(int id) => "closet/$id/";
  static String deleteClosetItem(int id) => "closet/$id/";
// chat
  static String chatSection() => "style-chat/session/";
  static String chatMessage() => "style-chat/message/";
  static String chathistory(int id) => "style-chat/session/$id/";
  static String chatSessionHistory() => "style-chat/session/";
  static String saportChat() => "support/";
  static String supportChatHistory(int id) => "support/$id/";

  // get product sugations
  static String getProductSuggestions() => "product/suggestions/";
  static String toggleFavorites() => "product/favorite/";
  static String savedItem() => "product/favorites/";
  //filter
  static String categories() => "product/categories/";
  static String occasions() => "product/occasions/";
  static String seasons() => "product/seasons/";
  static String budgets() => "product/budgets/";

  //home
  static String getDelyOutfit() => "closet/outfits/";

  // static String example() => "/api/";

  static String products(int pageNum, int perPage) =>
      "/products?page=$pageNum&per_page=$perPage";
  static String productDetails(int id) => "/products/$id";
}
