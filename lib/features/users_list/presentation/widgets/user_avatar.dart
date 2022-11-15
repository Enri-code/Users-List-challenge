import 'package:flutter/material.dart';
import 'package:owwn_flutter_test/app/theme/colors.dart';
import 'package:owwn_flutter_test/core/helpers/formatters.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';

class UserNameAvatar extends StatelessWidget {
  const UserNameAvatar({
    super.key,
    required this.user,
    this.size,
    this.fontSize,
  });

  final User user;
  final double? size;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPalette.greys[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  nameShortener(user.name),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
