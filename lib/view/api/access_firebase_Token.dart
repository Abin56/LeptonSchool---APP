import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String firebaseMessagingScope =
      'https://www.googleapis.com/auth/firebase.messaging';

  /// Retrieves the access token for Firebase Messaging.
  ///
  /// This function uses the service account credentials to authenticate with
  /// the Google API and obtain an access token for Firebase Messaging. The
  /// obtained access token is then returned.
  ///
  /// Returns:
  ///   A `Future` that resolves to a `String` representing the access token.
  ///
  /// Throws:
  ///   - `ClientException`: If there was an error while authenticating with
  ///     the Google API.
  ///   - `SocketException`: If there was a network-related error while
  ///     retrieving the access token.
  ///   - `FormatException`: If the response from the Google API was not in the
  ///     expected format.

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "lepton-school",
          "private_key_id": "a1e168051564303d6997b68edef11e2fab1db0f1",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCwi66nt4HzHHHl\n8skyovVxOprAxMKyYBU2iKrv50mqFapG5YfZjLyxp08xHMjiE3Ndk8ywC2ikdzNw\nGoiWhiKWhVpSB8ab/LcoeM4NpT//uwB1GoyX58X1yeQd02OgO6x+AuvjZE96fhMz\n/RfOGmKWjn5+8A87861q/Lcfrz5hlYKGncIt6tQLkOdlKxhdAEkoa676NhMsqSVb\nCFvDO3sUuG16lRofPVq6r9tVjjBfeTxKsiyUWLyAbqlmkKzMe8g8SOMPUf/M6KZ/\nNu4SF2uuIHrf3/aPrZDUYodZchfNE+5qZvKuriGqutnieJJN8oTpnoE5MlZ2pNpa\n9W85bfNJAgMBAAECggEAFDlUHyNe8A4UoB5hXPsc+cUYYDfKA+wM0gvy5PuOTT0h\nHfECUHIWVZWQdVRSUM+gmhopywrriFedXVy0w+WGxc5t69K3NjxLcQfxts901uNB\nqKiLbYVgAImJp78E/SCI4ICOLCTcE/CoW37FQNd17sBRDlKKtDf0aDqd8bO+BiiN\nKkL9/oEsrsLKdlTMugqoaDS8ElHNQqLb8f7c+19Q09pmvhkbYl4wYv7QZualfuzT\nqMUe8or/S2kfjNqdRsD2AVl6QYHPDpWGDmEMRYl4cGrMNdZ79xrrcHfES4vNLi42\nrG6NYHVFGhjpW/GVrshCTjmVnrFBTNjJuwz4H7FmRwKBgQDa+EluHKHtv0xvTVpG\nTBzUxkHKRcsgASucjJ/PVwZGujsbhPGa50IeVnaVGH83w83tim6lMvXgax9FIlgL\n4Z8mVP8us9FEBBeFhy/kz1Bq3I4KMl2nYEgnNPHpLmB7fYv6HXTPkspR3RR+8J2o\nuHRNWyXWaEVHFmq+RelCI8kyvwKBgQDOZsB7gN5mvCGCgZUlGl88kVFsBpWN3PkJ\n/wX8RvYY2MBOCcMon+EXFKV1KzS0mD+NGSJGUEDRMRHYCL8cjHeSDcT8mOEYhV2p\n+58UW3T6cieAJ3mwXWq/Yt9ltM8x0cJ5O0H4UGXQIbzyjgxv8IGBLWUDq1X70QY1\nQMGG5XpD9wKBgQCqIqqjVLn4iV+xR2/yGOd554VszafS+TXSkG0HY/2rbL3KVxSG\noFL+UX4XwI3wXUIe5CWuVBc5ROJqDBJPQQIwfXA88FiTuX4xMOXkqbQ5I591isa7\n6xKE7B1eabtrmBPvxX1iXxK2YsmvC/PkCVXMWRrgKepSHrfXmWhxDG8i7wKBgCkT\nBacORDQJqFmCVB3oG5/AA4YN4WEz4lN87sH/lSXorIxbIP1Ko86mCy9AA+MUkUER\nCWMYwW1f6H8nbnDN+1WTa+ogulrY34TeUBALC0JzySyVrn/Md1vS30YsLzdo2Nyr\nUDuMNFaxABr87bixEfSVBg8u35OXSzb5xgmETUqNAoGBANZ6Wp/PIk/XKkS+OGch\nGNJqwJda+POBRzngran4ZnURbgYDgnGtn5++YJUMUkSSlu56Cg9DnoPWjagaLirv\nQpB7S91zubvI9bclu51NYhT1UNr/wmajFyB+WlqA8nVS4lWXqCxA2ufUK1FtbxCX\nM5JrzsMepptXQ3h45/j+7xfg\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-uos1f@lepton-school.iam.gserviceaccount.com",
          "client_id": "117342624530769424733",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-uos1f%40lepton-school.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);
    final String accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
