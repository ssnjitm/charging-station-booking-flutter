import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/theme.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/providers/providers.dart';
import '../../../../shared/components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final stationsAsync = ref.watch(stationsProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${auth?.fullName.split(' ')[0] ?? 'Guest'}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Find your perfect charger',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.lg),
            child: Center(
              child: IconButton(
                onPressed: () => context.push('/profile'),
                icon: const Icon(Icons.person_outline),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stats Section
            Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Sessions',
                      value: '12',
                      icon: Icons.history,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: AppTheme.lg),
                  Expanded(
                    child: _StatCard(
                      label: 'Saved',
                      value: '8',
                      icon: Icons.favorite,
                      color: AppTheme.errorColor,
                    ),
                  ),
                  const SizedBox(width: AppTheme.lg),
                  Expanded(
                    child: _StatCard(
                      label: 'Wallet',
                      value: 'Rs. 500',
                      icon: Icons.wallet_giftcard,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // Featured Stations
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Stations',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => context.go('/map'),
                    child: Text(
                      'See All',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            // Stations List
            stationsAsync.when(
              data: (stations) {
                final featured = stations.take(5).toList();
                return Column(
                  children: featured.map((station) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.lg,
                        vertical: AppTheme.sm,
                      ),
                      child: _StationCard(station: station),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.lg),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.lg),
                  child: Text('Error loading stations: $error'),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.lg),
            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTheme.lg),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.map,
                          label: 'Map',
                          onTap: () => context.go('/map'),
                        ),
                      ),
                      const SizedBox(width: AppTheme.lg),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.history,
                          label: 'History',
                          onTap: () => context.go('/bookings'),
                        ),
                      ),
                      const SizedBox(width: AppTheme.lg),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.favorite,
                          label: 'Saved',
                          onTap: () => context.go('/favorites'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.xl),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: color.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  final ChargingStation station;

  const _StationCard({required this.station});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => context.push('/station/${station.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      station.address,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: '${station.availableSlots}/${station.totalSlots}',
                backgroundColor:
                    station.isAvailable ? AppTheme.secondaryColor : AppTheme.errorColor,
                textColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rs. ${station.pricePerKwh.toStringAsFixed(2)}/kWh',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
              ),
              Wrap(
                spacing: 4,
                children: station.chargerTypes.take(2).map((type) {
                  return Chip(
                    label: Text(type),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.md,
        vertical: AppTheme.lg,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
