// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'firebase_module.dart' as _i9;
import 'use_case/register_user.dart' as _i8;
import 'use_case/sign_in.dart' as _i5;
import 'use_case/sign_out.dart' as _i6;
import 'use_case/update_user_data.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseModule.auth);
  gh.lazySingleton<_i4.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i5.SignIn>(() => _i5.SignIn(get<_i3.FirebaseAuth>()));
  gh.factory<_i6.SignOut>(() => _i6.SignOut(get<_i3.FirebaseAuth>()));
  gh.factory<_i7.UpdateUserData>(
      () => _i7.UpdateUserData(get<_i4.FirebaseFirestore>()));
  gh.factory<_i8.RegisterUser>(() =>
      _i8.RegisterUser(get<_i3.FirebaseAuth>(), get<_i7.UpdateUserData>()));
  return get;
}

class _$FirebaseModule extends _i9.FirebaseModule {}
