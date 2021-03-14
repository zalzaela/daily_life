import 'package:flutter/material.dart';

class DeleteSnackBar extends SnackBar {
  DeleteSnackBar({
    Key key,
    @required String text,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted $text',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
