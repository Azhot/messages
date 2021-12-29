// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'firebase_module.dart' as _i15;
import 'use_case/add_message_to_conversation.dart' as _i12;
import 'use_case/create_conversation.dart' as _i13;
import 'use_case/get_conversations.dart' as _i5;
import 'use_case/get_messages.dart' as _i6;
import 'use_case/get_users.dart' as _i7;
import 'use_case/observe_auth_state_changes.dart' as _i8;
import 'use_case/register_user.dart' as _i14;
import 'use_case/sign_in.dart' as _i9;
import 'use_case/sign_out.dart' as _i10;
import 'use_case/update_user_data.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseModule.auth);
  gh.lazySingleton<_i4.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i5.GetConversations>(
      () => _i5.GetConversations(get<_i4.FirebaseFirestore>()));
  gh.factory<_i6.GetMessages>(
      () => _i6.GetMessages(get<_i4.FirebaseFirestore>()));
  gh.factory<_i7.GetUsers>(() => _i7.GetUsers(get<_i4.FirebaseFirestore>()));
  gh.factory<_i8.ObserveAuthStateChanges>(
      () => _i8.ObserveAuthStateChanges(get<_i3.FirebaseAuth>()));
  gh.factory<_i9.SignIn>(() => _i9.SignIn(get<_i3.FirebaseAuth>()));
  gh.factory<_i10.SignOut>(() => _i10.SignOut(get<_i3.FirebaseAuth>()));
  gh.factory<_i11.UpdateUserData>(
      () => _i11.UpdateUserData(get<_i4.FirebaseFirestore>()));
  gh.factory<_i12.AddMessageToConversation>(
      () => _i12.AddMessageToConversation(get<_i4.FirebaseFirestore>()));
  gh.factory<_i13.CreateConversation>(
      () => _i13.CreateConversation(get<_i4.FirebaseFirestore>()));
  gh.factory<_i14.RegisterUser>(() =>
      _i14.RegisterUser(get<_i3.FirebaseAuth>(), get<_i11.UpdateUserData>()));
  return get;
}

class _$FirebaseModule extends _i15.FirebaseModule {}
