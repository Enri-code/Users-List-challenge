import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/bloc/users_bloc.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/change_info.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/gender_icon.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/user_avatar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserProfileScreen extends StatefulWidget {
  ///Argument will be [User]
  static const routeName = 'UserProfileScreen';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late User user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments! as User;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Hero(
                        tag: 'name_avatar-${user.id}',
                        child: UserNameAvatar(
                          user: user,
                          size: 110,
                          fontSize: 28,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GenderIcon(gender: user.gender),
                      ),
                    ],
                  ),
                  _UserFieldsWidget(
                    userData: user,
                    onUpdate: (newUser) {
                      setState(() => user = newUser);
                      context.read<UsersBloc>().add(UpdateUserData(user));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  margin: EdgeInsets.zero,
                  primaryXAxis: NumericAxis(isVisible: false),
                  primaryYAxis: NumericAxis(isVisible: false),
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    shouldAlwaysShow: true,
                    lineType: TrackballLineType.none,
                    activationMode: ActivationMode.singleTap,
                    markerSettings: const TrackballMarkerSettings(
                      color: Colors.white,
                      markerVisibility: TrackballVisibilityMode.visible,
                    ),
                  ),
                  series: [
                    SplineSeries(
                      dataSource: user.statistics ?? [0],
                      color: Colors.white,
                      selectionBehavior: SelectionBehavior(
                        enable: true,
                        selectedBorderWidth: 3.5,
                        unselectedBorderWidth: 1.5,
                      ),
                      xValueMapper: (_, index) => index,
                      yValueMapper: (data, _) => data,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class _UserFieldsWidget extends StatelessWidget {
  const _UserFieldsWidget({required this.userData, required this.onUpdate});

  final User userData;
  final Function(User newUser) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => ChangeUserInfoDialog(
                initialValue: userData.name,
                onSave: (value) => onUpdate(userData.copyWith(name: value)),
              ),
            );
          },
          child: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              return Text(userData.name, style: const TextStyle(fontSize: 28));
            },
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => ChangeUserInfoDialog(
                initialValue: userData.email,
                onSave: (value) => onUpdate(userData.copyWith(email: value)),
              ),
            );
          },
          child: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              return Text(
                userData.email.isEmpty ? 'No email address' : userData.email,
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              );
            },
          ),
        ),
      ],
    );
  }
}
