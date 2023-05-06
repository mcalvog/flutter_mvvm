import 'package:get_it/get_it.dart';

import '../../data/artists/artists_data_impl.dart';
import '../../data/artists/remote/artists_remote_impl.dart';
import '../../data/auth/auth_data_impl.dart';
import '../../data/auth/remote/auth_remote_impl.dart';
import '../../data/remote/http_client.dart';
import '../../domain/artists_repository.dart';
import '../../domain/auth_repository.dart';
import '../../presentation/view/artist/viewmodel/artists_view_model.dart';
import '../../presentation/view/auth/viewmodel/auth_view_model.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupAuthModule();
    _setupArtistsModule();
  }

  _setupMainModule() {
    inject.registerSingleton(HttpClient());
  }

  _setupAuthModule() {
    inject.registerFactory(() => AuthRemoteImpl(inject.get()));
    inject.registerFactory<AuthRepository>(() => AuthDataImpl(inject.get()));
    inject.registerFactory(() => AuthViewModel(inject.get()));
  }

  _setupArtistsModule() {
    inject.registerFactory(() => ArtistsRemoteImpl(inject.get()));
    inject.registerFactory<ArtistsRepository>(
        () => ArtistsDataImpl(inject.get()));
    inject.registerFactory(() => ArtistsViewModel(inject.get()));
  }
}
