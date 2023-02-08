
import 'package:bloc_login/locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;


@InjectableInit()
void configureDependencies() => getIt.init();