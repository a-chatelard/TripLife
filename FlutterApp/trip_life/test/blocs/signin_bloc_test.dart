import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_life/application/blocs/signin_bloc/signin_bloc.dart';

import '../mocks/repositories/mock_authentication_repository.dart';
import '../mocks/repositories/mock_friend_repository.dart';

void main() {
  group('Signin Bloc test', () {
    late SigninBloc signinBloc;
    MockAuthenticationRepository mockAuthenticationRepository;
    MockFriendRepository mockFriendRepository;

    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockFriendRepository = MockFriendRepository();
      signinBloc = SigninBloc(
          authenticationRepository: mockAuthenticationRepository,
          friendRepository: mockFriendRepository);
    });

    blocTest<SigninBloc, SigninState>(
      "emits SigninState.succes for SigninRequested",
      build: () => signinBloc,
      act: (bloc) => bloc.add(SigninRequested("test@triplife.fr", "123Soleil")),
      expect: () => [const SigninState.loading(), const SigninState.succes()],
    );

    tearDown(() => signinBloc.close());
  });
}
