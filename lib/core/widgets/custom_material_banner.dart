import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class buildCustomMaterialbar extends StatelessWidget {
  const buildCustomMaterialbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0.1,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: 'Oh Hey!!',
        message:
            'This is an example error message that will be shown in the body of materialBanner!',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
        // to configure for material banner
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}
