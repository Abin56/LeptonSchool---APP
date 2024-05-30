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
          {
            "type": "service_account",
            "project_id": "lepton-school",
            "private_key_id": "4807cedacb38db92a0ed536a4a37d0a11441677d",
            "private_key":
                "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDUKvBxZQ2wA6Pd\n1cmjSEnIEXl0FloheQueC0YeRpK+LNhEy5l6IojiaMH6fpcKJH1MkwedYS/d4XzN\nTwaFnH9dEjSZ5eIyTvPyt6oci5HjWkkEAyiQgDpM7uYBUKcFM7EPzQj0JN0es07j\nPpyQsv1YCwTGssOWJhHBkKsCoU+eaIk12vTt43/Q9Nqubpxzf+EkG2xYne8sd0pp\nABW2EE0MntovwIsWAk64WfuOBthTptSIXIah87GTyMLCs7tBbycdbDZ0m6JhEST4\ni9UYvQPyIzJaMzZ6nr191aSJB9UzSe60/IXfUnHTFzsPCI5h1Al7m8qi0u8I/xYj\n7dSESaivAgMBAAECggEAREKQWxs0/SUeqndmySavvjOJDMVIOC62gyGDbKgt/At3\nhSKv/TBxM86aYhoqQ/Qbb/B56bNj8BHk0jUTlxcTjwEVdVIVpTPrnnJiw45P4IKi\nrSzK9zqaBzhxPYkSQ0UvOTMxJ0NY9NChl9EEFDXR9mqNHdRTwtH6snj13AHEGOVY\nlnTPZs9aJPAFxw6ew86+OlsCLIEpi2Z1oibryXfjt5N4ltOg5gh0I7CnUA3uedLj\nQnvNTUo636jrPJeRiCGYEqFp+B8sExtd9ONPuRiOIOhedYKTv7KH2/OP95QHalLj\nzT/J99xv6xyOLPi+SZ1F/nFMrBEmotoSShN2bYusSQKBgQD8dbM3qb8sd0Kxi1Qi\nS/IWAX0gDnK74LUQyZocM5zbBfuKPJB+Q5+tD8ysqGHMnQsMP1z1x3f1Thg5A9oy\nyVgClxAnR98S7zFT6Ti3aiuLo5AfGout4auTYBkmBmGP0VEi+pQa+U5f9W6xIqnf\nIR74aGwNq7mXJpGMlUE6VWnwlQKBgQDXJJh8RzqRrjKVQTWHvEdvHWgnQ7rR0Ygn\nFmnAV+x+BBLmusOn1ZYYs9JYAbAvYBjcghLvEa77ZXdK/i5pYPjGVGRhhd1HYfOe\nTlW+Qhs5CGdZjGY7/pThXAQnP7bhZQDkfqpUidV/kXpWZrgT/Cy/omPStLZbzlyf\nbAzXKz4PMwKBgGtu5vpMCSeyBLarNP13VijZL1ch7t9Wy5a+RA+2QwzNqfJ0vYSN\n4Hh0HcRnz16UgewPVs7cuIayWgqBQiyUlBheEqi0pBBZq6Mqv1EGJEvDKgSidkhj\nnXEU1v7gfkoGaEG7YqVr7FdXiWhl+OYUISrSvRDAQDU7W3r41Q4u5OtVAoGBAMeG\n3RSFSsBI+giKTYbxCp72et3PZreox8jYdIM6B85nINBzbXl+EJIgU3fjOO73BJec\n2sp1b/8e/x/B1HFOyenF4sK/T5UgNrwekk69KFogfRkDqN0DIjhPClsMMCOhdM50\n2qtEmYiR9w+ifB2sxiOEC2giyO0j2arQnqf/JrMZAoGAC07q5Iq+isOnA6PjPa6V\nIDjHSk85csx7ifjJDiy9FwHI62tA+2veEquXXMsxTRDwDYPK4A1uFtmC41B+GXoH\nNkat/tndkXa1gfc3bbVqqlO3MpNx4pdJRpDbabzmY4bViMaFwRgPR40jwwgiRvnX\nloQH+hkqz16GtmNQvIdN0FQ=\n-----END PRIVATE KEY-----\n",
            "client_email":
                "firebase-cloud-messaging-api@lepton-school.iam.gserviceaccount.com",
            "client_id": "100202019203129957017",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url":
                "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url":
                "https://www.googleapis.com/robot/v1/metadata/x509/firebase-cloud-messaging-api%40lepton-school.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        }),
        [firebaseMessagingScope]);
    final String accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
