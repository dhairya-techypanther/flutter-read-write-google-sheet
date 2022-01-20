
import 'package:demo/Model/User.dart';
import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsAPI {
  static const credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-338705",
  "private_key_id": "c79f0979575f19f20f10c3081ee8dccfd4b58de2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQClemQ4abZ2LpDD\nmJda3HCwkXmyUN5jnCp1vtafNGFb4hWf5l0XQiyJYD1QejVwJKOcYtufcQCaJMNZ\nLr9r/0mnrdAsb/e1cc0kUr67ySz1t/n9OsZ/3YEEXlY3VSlryU8TKFjhU6u51zkU\nUlMLPzfocV/rhc+iXmP0jLZM8MvzQpTtjfBUdt2CwWaW9r6ZaCSth+gdNv1vxBLG\nn6LwiKGJdESyQh7k51iuQ9uVcNdS6s7hPih07RMfk92TI2KwegNYwJuOOcKeSgz6\n/F894QonRO7fmvaPTBgIBupcZSrFWS032xYivJFB6/DxgneGFoKtuzfIGvAYSAvF\n9DXSZWHrAgMBAAECggEAJQiWI1XtQte7CDs/LFOHWMzF6pVUoABUNFPIXorvewvH\nASkiDlF9/CSwtDEVgoqAn0A0nKNCmjy+B1iB+J6CkmdA3qEUU+QrIATwsMAeMsPA\ny956jCU7eYnPS8TgZ0H/U29FLPB3zziOirC96xdz4K525BPnWxQ61IElT2TYkBEr\ndeLAbs0B8xDeeVvFZpwA2Dm3KWExpLFAknEK677WvKW72nISomTYm1xnvPsKzwc1\nz/8x0bLNg832qW0GxsBWvoQd8vBYzQBlS2A5nDlwxYKFky3dso2bKf1d3gw4WLK5\n6148+x+nm0IqKDC0oOiA8uR/VwnNZj67w+Hv87uBwQKBgQDRQ8vAPVjt43UwW59e\nlTWwuLEh11lcNmQlv5GGGkjeIQHkvD3h/lDU1bW/35TPhuu9UZJIgnAqAfv9430a\nAfXRetZlT6gi6ZNioqmdHan8MFaorDAuNGO6wirqj/WzzA3photOGdAMyk27RJ0A\n5jaA0Vt8eF9aivkI3tH7mAHeiwKBgQDKbzI4cPIc7pPegNbmNvbSWC2enYyW+wNK\nx3V8u9PjZJlBAvx8oph8wYPyvR/O//UAFgQObfKeHznAu65PLbPn4ZmiqynUHVkE\ny+DM55fJF2PuYHVlnBN/nLyi+F2whYT1AfbqjYeITwYN+nuAnXJT8NcCYBotk6jd\neG1e1c9WIQKBgQCieGJ+tKKQv6JCk0AerPXsaNiNj6a/YzNJ43vWhB3C6BmSP1xE\nU7DqLapYd/wPS49Hg0dxqGPxGW1N5ws/3/m8VASUz82YnYRidiv94gQR2m3NszIN\nDXvIievMBU0b9PdwMZeCYaQX6hGDrXfANPxn8yN2dfaCU5eZ/XVGQvRglQKBgQCi\n/JB0vQtSnAxWU2mzBYIIrZJdaQAu938ZECrZ+OiK5w41N9BOESOxHqW8JOWdZpu+\nK/usGn4DLaT0NqgLfAKjqhJm1GTjMZXgtL4UfErLT5fX77XVz6orTujaVhoo6/e2\nxJQnGTiMWQPI8WnKjfnk975FXVb2ZzLIzhNRDdjXwQKBgQCMOKni4GY+PhzNyC8A\ndDDt9XXPkngozsmcwyA4vOBJaZShdM/goTAEoygB/uoub+smCt0EXxPXg8KE8NEy\nTY1kM10M2PTgyU+LuoJenfrvi8vfIXjKqD2rz6QtnMqLgNq/92YZQgW8EVGDakyC\nsyQppEipif5bfmNysVHy8y/tIA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-338705.iam.gserviceaccount.com",
  "client_id": "118267783275098160964",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-338705.iam.gserviceaccount.com"
  }
''';

  static const spreadsheetId = '169JpUBEiGaY6dMnadnhN92LgYdxFKbypFDtlqeBDPrM';
  static final gSheets = GSheets(credentials);
  static Worksheet? userSheet;

  static Future init() async {
    try {
      final spreadsheet = await gSheets.spreadsheet(spreadsheetId);
      userSheet = await getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      userSheet!.values.insertRow(2, firstRow);
    } catch(e) {
      if (kDebugMode) {
        print('Init error: $e');
      }
    }
  }

  static Future<Worksheet?> getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    }catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }

  }
  static Future insert(Map<String, dynamic> rowList) async{
if (kDebugMode) {
  print(rowList);
}
    if (userSheet == null) return; if (kDebugMode) {
      print("Data coming");
    }

       userSheet!.values.map.insertRow(2, rowList);
    if (kDebugMode) {
      print("data is going");
    }
  }

}
