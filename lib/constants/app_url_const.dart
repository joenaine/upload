class AppUrl {
  static const String baseUrl = 'https://izidosapi.azurewebsites.net';

  static const String login = '$baseUrl/api/account/token';
  static const String register = '$baseUrl/api/account/register';
  static const String sendSms = '$baseUrl/api/account/send-sms';
  static const String confirmSms = '$baseUrl/api/account/confirm-sms';

  static const String getProfile = '$baseUrl/api/profile/get-profile';
  static const String updateProfile = '$baseUrl/api/profile/update-profile';
  static const String locations = '$baseUrl/api/Locations';
  static const String myLocations = '$baseUrl/api/Locations/MyLocations';

  static const String regions = '$baseUrl/api/Regions';
  static const String game = '$baseUrl/api/Game';
  static const String myGames = '$baseUrl/api/Game/MyGames';
  static const String gametypes = '$baseUrl/api/GameTypes';
  static const String gameJoin = '$baseUrl/api/Game/Join';
  static const String addReserve = '$baseUrl/api/Game/AddReserve';
  static const String gameLeave = '$baseUrl/api/Game/Leave';

  static const String confirmPayment = '$baseUrl/api/Payment/ConfirmPayment';
  static const String deletePlayerFromGame = '$baseUrl/api/Players';

  static const String groups = '$baseUrl/api/Groups';
  static const String myGroups = '$baseUrl/api/Groups/MyGroups';

  static const String password = '$baseUrl/api/settings/change-password';
  static const String email = '$baseUrl/api/settings/change-email';
  static const String setNotifications =
      '$baseUrl/api/settings/set-notifications';

  static const String sendemail = '$baseUrl/api/support/send-email';
}
