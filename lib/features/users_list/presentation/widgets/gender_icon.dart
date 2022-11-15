import 'package:flutter/material.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';

class GenderIcon extends StatelessWidget {
  const GenderIcon({required this.gender});

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: Colors.black,
              size: 22,
            ),
        child: Builder(
          builder: (_) {
            if (gender == Gender.male) return const Icon(Icons.male);
            return const Icon(Icons.female);
          },
        ),
      ),
    );
  }
}
