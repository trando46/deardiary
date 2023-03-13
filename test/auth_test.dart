import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  // Set up
  late MockGoogleSignIn GoogleSignIn;

  setUp(() {
    // Create the object
    GoogleSignIn = MockGoogleSignIn();
  });

  test('Verify that the current user is not null', () async {
    // Arrange
    final accountSignIn = await GoogleSignIn.signIn();

    // Act
    final signInAuthentication = await accountSignIn!.authentication;

    // Reset

    //Assert
    expect(signInAuthentication, isNotNull);
    expect(GoogleSignIn.currentUser, isNotNull);
  });

  test('Verify that when the user cancel with login in should return null', () async {
        // Arrange
        GoogleSignIn.setIsCancelled(true);

        // Act
        final accountSignIn = await GoogleSignIn.signIn();

        // Reset

        // Assert
        expect(accountSignIn, isNull);
  });

}