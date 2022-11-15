import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/app/theme/colors.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/bloc/users_bloc.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/screens/user_profile.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/user_avatar.dart';

enum TilePosition { top, bottom, between }

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    this.position = TilePosition.between,
    required this.user,
  });

  final User user;
  final TilePosition position;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: ColorPalette.greys[500],
        borderRadius: () {
          switch (position) {
            case TilePosition.bottom:
              return const BorderRadius.vertical(bottom: Radius.circular(12));
            case TilePosition.top:
              return const BorderRadius.vertical(top: Radius.circular(12));
            default:
              return null;
          }
        }(),
      ),
      child: InkResponse(
        onTap: () {
          Navigator.of(context).pushNamed(
            UserProfileScreen.routeName,
            arguments: user,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Hero(
                tag: 'name_avatar-${user.id}',
                child: UserNameAvatar(user: user, size: 38, fontSize: 14),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, overflow: TextOverflow.ellipsis),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
