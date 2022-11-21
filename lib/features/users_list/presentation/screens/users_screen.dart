import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/core/helpers/event_status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/bloc/users_bloc.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/user_tile.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = 'UsersScreen';
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    final usersBloc = context.read<UsersBloc>();

    usersBloc.add(GetUsers());

    _scrollController.addListener(() {
      if (usersBloc.state.sections.map((e) => e.users).length > 120) return;

      if (usersBloc.state.status == EventStatus.loading ||
          usersBloc.state.status == EventStatus.error) return;

      if (_scrollController.position.maxScrollExtent -
              _scrollController.offset <
          100) {
        usersBloc.add(GetUsers());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _sectionBuilder(UsersSection section) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(section.status.title),
          ),
        ),
        const SizedBox(height: 8),
        ...section.users.map(
          (e) => UserTile(
            user: e,
            position: () {
              if (e == section.users.first) return TilePosition.top;
              if (e == section.users.last) return TilePosition.bottom;
              return TilePosition.between;
            }(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        buildWhen: (prev, curr) {
          return prev.sections != curr.sections || prev.status != curr.status;
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height * 0.48,
                title: const Text(
                  'Users',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/images/users_list_bg.png',
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                    ),
                    _BgOverlay(scrollController: _scrollController),
                  ],
                ),
              ),
              ...state.sections.map((e) {
                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(child: _sectionBuilder(e)),
                );
              }),
              if (state.status == EventStatus.loading)
                const SliverPadding(
                  padding: EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              else if (state.status == EventStatus.error)
                const _ErrorWidget(),
            ],
          );
        },
      ),
    );
  }
}

class _BgOverlay extends StatelessWidget {
  const _BgOverlay({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: scrollController,
          builder: (context, _) {
            final double animVal =
                (scrollController.offset + 1) / constraints.maxHeight;
            return Container(
              color: Color.lerp(
                Colors.transparent,
                Colors.black,
                clampDouble(animVal, 0, 1),
              ),
            );
          },
        );
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text('Error fetching users'),
            ),
            ElevatedButton(
              onPressed: () => context.read<UsersBloc>().add(GetUsers()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
