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
          "project_id": "pushnotification-23-may",
          "private_key_id": "af2c4c2a65d7c49a0390a9b916460bafbc88eefc",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCYk9dIZ+i3uxzp\n/ysIY5wAumvk+9WeNVipDKfVvksk9YaMB6QQMy6dgCkoTtZVTksojKyOBgcTYV5H\nYngwkTGOOwFCImCBqPFwOPMFq8HGUxohp5XjXcOjpsVBjpGTzTDHkMEu6G3qWzRS\nkjfIF6rBbBLpGqlvJj462MQ9Vqdme1jpK11NcFJjBn4eGIRTD3ekQNP/dPC1kjZN\nI31gHJeRa8O93neNEghaZgCas35Bcg1rWzZNYxplPn/UuDQlwgzvpsOeqUfgdkdc\nPaHVAL+L31fOayqGGUzrCgEwOZu+QS5SMHYPmkIOAus5cmhFXMoko+ULp1juGYG9\n9ls9teWDAgMBAAECggEAHtAEcu/hFHGqJitM0nXjRFZhga3F9xxI2mLe5hB29nDL\nCi5k2IythksihKxfJn0YOokmM8xN04EfXAUrxosb2eBaobN1j9nBYGtv0J5eFKIl\nrdQ9NdxyrPL59QJIrfOLPVIjYUi5IdHnYCF9OGBnMIaVzxN+Uh8EBDhQcR610cEZ\nUhbqkLY5lQBZNykxv0JOFJn9Lxb4Bsi8asMAptSgigEdNbYMVNRnw8XP+Q0CBUSQ\nAS/5PgwLC/EUeCCoqBuKxW36RoJZv7uFzbFarjpYaqoj50cPWWkwxI+g/+9/+fl6\nbd7aFCtjPYO/F6zxTZSG3ydBxSSK+ViqaE0LlqP3AQKBgQDNaTzQ43+wv/HBF+3v\nLDttcAMgX9tkt/tobqiwFmkmK2UGuMCaqhUxKFmgNOxoLyKlJSGqCsQpv39h7QRh\nyhYselFoVRZhcrDx9bjNUFEZVnrS4OqHhWoHfg06fA+WkO4dOcsPCe7MyLsxEC5+\nqepDsduU1oFxyGwS80qsLvDiAwKBgQC+J4z4s4EOqszRdZxbnivjOv2B7j56uO1g\nxFIAEMoa+5Ix2l1JXNUFnUrM2r451KxX70K6MtngEjLHJjckpXC/p1u+0LV1306U\nJNQDAbxiMxl1cg7ypYgZT1jHQPgPUqCuWCTgVr7BDplIjbr3iwxPU/eWlnlnI8AL\nkISTOs1WgQKBgAUZdrwM2c+uhDbx/CMy6urFnB5CovS2KJSoIqH0fHnJHAH1tjpg\nvJPy137FsZTIjsigylwpVkNfEK+Crdgrpy9Ffh3j9uFGcqQfII5gTxMc9YGkuc3R\nfxdehr+L8use//pTw/nEmlwVI6iNKUpVt44krTndtWr4uc4iohjyNWK3AoGAYPtp\nAbsDeoiQN9AlM/EC7zy56Neq1AqXPwBB1ji563MdSAHYDD+lgdyMNtjlpjcawyqL\nPM4MoySE819BRpZ+X7EqsLJfqkN/Hz19SB9NhkQLmwPWLdlRBZ+bZtxy59W7j8/y\n1txHI82fTgrDLdekKp1nrE0IlBr+qqdFhpW5/oECgYB907PLSTKdjN9T4nT24Pnb\nyEmbtKodiDMPr6lNCt6Ux8VjiHxlr8TOsJ1tXCpF+EaF0GimdqP19ltpKD2pVTiZ\nDYVSVmQWeGYSa9zZlFO1+nX0pq65R/aZRGLtfDuACzewSIxblKFEm2V/SlYsnyJi\nj4avllSRC3si2WApqPjDUA==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-pby1w@pushnotification-23-may.iam.gserviceaccount.com",
          "client_id": "102602078131839345353",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-pby1w%40pushnotification-23-may.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);
    final String accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
