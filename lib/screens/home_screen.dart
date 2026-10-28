import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../providers/medication_provider.dart';
import '../utils/form_label.dart';
import 'add_medication_screen.dart';
import 'medication_info_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<MedicationProvider>(context, listen: false).loadMedications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final medProvider = Provider.of<MedicationProvider>(context);
    final total = medProvider.totalCount;
    final taken = medProvider.takenCount;
    final progress = total == 0 ? 0.0 : taken / total;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            tooltip: l10n.changeLanguage,
            onSelected: saveLocale,
            itemBuilder: (context) => const [
              PopupMenuItem(value: Locale('en'), child: Text('English')),
              PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
              PopupMenuItem(value: Locale('fr'), child: Text('Français')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.favorite_rounded,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.greeting,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        total == 0
                            ? l10n.addFirstMedication
                            : l10n.keepUpGoodWork,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.tertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 7,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.dosesTakenToday(taken, total),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.todaysProgress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: medProvider.medications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.medication_outlined,
                          size: 56,
                          color: Colors.grey[350],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.noMedicationsYet,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: medProvider.medications.length,
                    itemBuilder: (context, index) {
                      final med = medProvider.medications[index];
                      final borderColor = med.isTaken
                          ? Colors.green
                          : med.isMissed
                          ? Colors.red
                          : Colors.blue;

                      return Dismissible(
                        key: ValueKey(med.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: const EdgeInsetsDirectional.only(end: 20),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) => showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(l10n.deleteConfirmTitle),
                            content: Text(l10n.deleteConfirmBody(med.name)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(l10n.cancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(l10n.delete),
                              ),
                            ],
                          ),
                        ).then((confirmed) => confirmed ?? false),
                        onDismissed: (_) {
                          medProvider.deleteMedication(med.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.medicationDeleted(med.name)),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: BorderDirectional(
                              start: BorderSide(color: borderColor, width: 4),
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.teal.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.medication_outlined,
                                    color: Colors.teal,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        med.name,
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 4,
                                        children: [
                                          _InfoChip(
                                            icon: Icons.medication_liquid,
                                            label:
                                                '${med.dosage} • ${formLabel(l10n, med.form)}',
                                          ),
                                          _InfoChip(
                                            icon: Icons.schedule,
                                            label: med.time,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Column(
                                  children: [
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: med.isTaken
                                          ? null
                                          : () =>
                                                medProvider.markAsTaken(med.id),
                                      icon: Icon(
                                        med.isTaken
                                            ? Icons.check_circle
                                            : Icons.circle_outlined,
                                        color: med.isTaken
                                            ? Colors.green
                                            : Colors.grey[400],
                                      ),
                                      tooltip: l10n.takenButton,
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: Icon(
                                        Icons.info_outline,
                                        color: colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MedicationInfoScreen(
                                                  medicationName: med.name,
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMedicationScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addMedication),
      ),
    );
  }
}

/// A small pill showing an icon + label, used for dosage/time metadata
/// on a medication card.
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
