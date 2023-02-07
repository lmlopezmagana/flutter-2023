import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_infinite_list/dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();