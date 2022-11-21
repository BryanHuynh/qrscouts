import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR_Code extends StatelessWidget {
  final String url;
  const QR_Code({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: url,
      version: QrVersions.auto,
      size: 200.0,
    );
  }
}
