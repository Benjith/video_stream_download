import 'dart:io';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:flutter_video_stream/screens/widgets/custom_widgets.dart';
import 'package:path_provider/path_provider.dart';

class EncryptData {
  static String encryptfile(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('123456');
    String encFilepath;
    try {
      encFilepath = crypt.encryptFileSync(path);
      print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath');
      //delete plain file
      File(path).delete();
    } catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The encryption has been completed unsuccessfully.');
        print(e.message);
      } else {
        return 'ERROR';
      }
    }
    return encFilepath;
  }

  static Future<String> decryptfile(String path, String filename) async {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('123456');
    String decFilepath;
    try {
      Directory temp = await getTemporaryDirectory();
      decFilepath = crypt.decryptFileSync(path, '${temp.path}/$filename');
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('File content: ' + File(decFilepath).path);
    } catch (e) {
      print(e);

      // if (e.type == AesCryptExceptionType.destFileExists) {
      //   print('The decryption has been completed unsuccessfully.');
      //   print(e.message);
      // } else {
      //   return 'ERROR';
      // }
    }
    return decFilepath;
  }
}
