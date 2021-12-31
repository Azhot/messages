import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/dependency_injection/injection.config.dart';

final inject = GetIt.instance;

@injectableInit
Future<void> configureDependencyInjection({String? environment}) async =>
    await $initGetIt(inject, environment: environment);
