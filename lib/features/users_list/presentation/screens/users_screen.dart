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
    context.read<UsersBloc>().add(GetUsers());

    _scrollController.addListener(_updateOnScroll);

    super.initState();
  }

  void _updateOnScroll() {
    //[120] is the amount of users from data source.
    //This was hard-coded to save time, but should not be done normally
    final bloc = context.read<UsersBloc>();
    if (bloc.state.sections.map((e) => e.users).length > 120) return;

    if (bloc.state.status == EventStatus.loading ||
        bloc.state.status == EventStatus.error) return;

    if (_scrollController.position.maxScrollExtent - _scrollController.offset <
        100) {
      bloc.add(GetUsers());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Iterable<Widget> _foldSubSection(Iterable<Iterable> section) {
    return section.fold([], (prev, curr) => [...prev, ...curr]);
  }

  Iterable<Widget> _sectionBuilder(UsersSection section) {
    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        sliver: SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(section.status.title),
            ),
          ),
        ),
      ),
      ...section.users.map(
        (e) => SliverToBoxAdapter(
          child: UserTile(
            user: e,
            position: () {
              if (e == section.users.first) return TilePosition.top;
              if (e == section.users.last) return TilePosition.bottom;
              return TilePosition.between;
            }(),
          ),
        ),
      ),
    ];
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
                flexibleSpace: _ImageBG(scrollController: _scrollController),
              ),
              ..._foldSubSection(state.sections.map(_sectionBuilder)),

              if (state.status == EventStatus.loading)
                const SliverPadding(
                  padding: EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              else if (state.status == EventStatus.error)
                const _ErrorSliver(),
            ],
          );
        },
      ),
    );
  }
}

class _ImageBG extends StatelessWidget {
  const _ImageBG({
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/users_list_bg.png', fit: BoxFit.cover),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          ),
        ),
        _BgOverlay(scrollController: _scrollController),
      ],
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

class _ErrorSliver extends StatelessWidget {
  const _ErrorSliver();

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
