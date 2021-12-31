// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import 'firebase_module.dart' as _i19;
import 'shared_pref_module.dart' as _i20;
import 'use_case/add_message_to_conversation.dart' as _i15;
import 'use_case/create_conversation.dart' as _i16;
import 'use_case/delete_conversation.dart' as _i17;
import 'use_case/get_conversation_subtitle.dart' as _i5;
import 'use_case/get_conversations.dart' as _i6;
import 'use_case/get_messages.dart' as _i7;
import 'use_case/get_user_name.dart' as _i8;
import 'use_case/get_users.dart' as _i9;
import 'use_case/observe_auth_state_changes.dart' as _i10;
import 'use_case/register_user.dart' as _i18;
import 'use_case/sign_in.dart' as _i12;
import 'use_case/sign_out.dart' as _i13;
import 'use_case/update_user_data.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  final sharedPrefModule = _$SharedPrefModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseModule.auth);
  gh.lazySingleton<_i4.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i5.GetConversationSubtitle>(
      () => _i5.GetConversationSubtitle(get<_i4.FirebaseFirestore>()));
  gh.factory<_i6.GetConversations>(
      () => _i6.GetConversations(get<_i4.FirebaseFirestore>()));
  gh.factory<_i7.GetMessages>(
      () => _i7.GetMessages(get<_i4.FirebaseFirestore>()));
  gh.factory<_i8.GetUserName>(
      () => _i8.GetUserName(get<_i4.FirebaseFirestore>()));
  gh.factory<_i9.GetUsers>(() => _i9.GetUsers(get<_i4.FirebaseFirestore>()));
  gh.factory<_i10.ObserveAuthStateChanges>(
      () => _i10.ObserveAuthStateChanges(get<_i3.FirebaseAuth>()));
  await gh.lazySingletonAsync<_i11.SharedPreferences>(
      () => sharedPrefModule.sharedPreferences,
      preResolve: true);
  gh.factory<_i12.SignIn>(() => _i12.SignIn(get<_i3.FirebaseAuth>()));
  gh.factory<_i13.SignOut>(() => _i13.SignOut(get<_i3.FirebaseAuth>()));
  gh.factory<_i14.UpdateUserData>(
      () => _i14.UpdateUserData(get<_i4.FirebaseFirestore>()));
  gh.factory<_i15.AddMessageToConversation>(
      () => _i15.AddMessageToConversation(get<_i4.FirebaseFirestore>()));
  gh.factory<_i16.CreateConversation>(
      () => _i16.CreateConversation(get<_i4.FirebaseFirestore>()));
  gh.factory<_i17.DeleteConversation>(
      () => _i17.DeleteConversation(get<_i4.FirebaseFirestore>()));
  gh.factory<_i18.RegisterUser>(() =>
      _i18.RegisterUser(get<_i3.FirebaseAuth>(), get<_i14.UpdateUserData>()));
  return get;
}

class _$FirebaseModule extends _i19.FirebaseModule {}

class _$SharedPrefModule extends _i20.SharedPrefModule {}
