import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternet {
  Future<String> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    print('''The statement 'this machine is connected to the Internet' is: ''');
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    print(
      isConnected.toString(),
    );

    return isConnected.toString();
  }

  Future<bool> isConected ()async{
    await CheckInternet().execute(InternetConnectionChecker());
    final InternetConnectionChecker customInstance =
    InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 0),
      checkInterval: const Duration(seconds: 0),
    );
    // Check internet connection with created instance

    String checkInternt=await CheckInternet().execute(customInstance);
    return checkInternt=="true";

  }
}


