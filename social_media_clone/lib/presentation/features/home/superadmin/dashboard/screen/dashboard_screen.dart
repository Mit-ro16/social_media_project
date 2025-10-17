import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/core/network/failure.dart';
import 'package:social_media_clone/presentation/features/home/superadmin/dashboard/provider/dashboard_provider.dart';
import 'package:social_media_clone/presentation/features/home/superadmin/widgets/user_card.dart';

@RoutePage()
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        centerTitle: true,
      ),
      body: usersState.when(
        data: (users) => RefreshIndicator(
          onRefresh: () => ref.read(dashboardProvider.notifier).fetchAllUsers(),
          child: users.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return UserCard(
                      user: user,
                      onMakeModerator: () async {
                        final result = await ref
                            .read(dashboardProvider.notifier)
                            .makeModerator(user.id);
                        result.fold(
                          (failure) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${failure.message}'))),
                          (success) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(success))),
                        );
                      },
                      onRemoveModerator: () async {
                        final result = await ref
                            .read(dashboardProvider.notifier)
                            .removeModerator(user.id);
                        result.fold(
                          (failure) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${failure.message}'))),
                          (success) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(success))),
                        );
                      },
                    );
                  },
                ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          final errorMessage = err is Failure ? err.message : err.toString();
          return Center(child: Text('Error: $errorMessage'));
        },
      ),
    );
  }
}
