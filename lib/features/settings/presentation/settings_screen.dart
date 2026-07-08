import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/providers/auth/auth_provider.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/d_pad.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:gamespotlight/features/settings/models/setting_tab.dart';
import 'package:go_router/go_router.dart';

const _tabs = [
  SettingsTab(label: 'PERFIL Y CUENTA', icon: Icons.person_outline),
  SettingsTab(label: 'PANTALLA Y AUDIO', icon: Icons.tv_outlined),
  SettingsTab(label: 'NOTIFICACIONES', icon: Icons.notifications_outlined),
  SettingsTab(label: 'PRIVACIDAD Y SEGURIDAD', icon: Icons.shield_outlined),
  SettingsTab(label: 'ACERCA DE', icon: Icons.info_outline),
];

const _bgCard = Color(0xFF1C1A35);
const _purple = Color(0xFF7B5CF5);
const _purpleDim = Color(0xFF3D2F7A);
const _red = Color(0xFF8B1A2A);
const _textPrimary = Colors.white;
const _textSecondary = Color(0xFFB0ADCC);
const _divider = Color(0xFF2A2845);

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  FocusZone _zone = FocusZone.sidebar;
  int _selectedTab = 0;
  int _focusedTab = 0;
  int _focusedAction = 0;

  static const _actionCount = 4;

  KeyEventResult _handleAction(DPadAction action) {
    switch (_zone) {
      case FocusZone.sidebar:
        return _handleSidebarZone(action);
      case FocusZone.tabs:
        return _handleTabsZone(action);
      case FocusZone.actions:
        return _handleActionsZone(action);
    }
  }

  KeyEventResult _handleSidebarZone(DPadAction action) {
    if (action == DPadAction.right) {
      setState(() {
        _zone = FocusZone.tabs;
        _focusedTab = _selectedTab;
      });
    }
    return KeyEventResult.ignored;
  }

  KeyEventResult _handleTabsZone(DPadAction action) {
    switch (action) {
      case DPadAction.up:
        setState(
          () => _focusedTab = (_focusedTab - 1).clamp(0, _tabs.length - 1),
        );
        return KeyEventResult.handled;
      case DPadAction.down:
        setState(
          () => _focusedTab = (_focusedTab + 1).clamp(0, _tabs.length - 1),
        );
        return KeyEventResult.handled;
      case DPadAction.left:
        setState(() => _zone = FocusZone.sidebar);
        return KeyEventResult.ignored;
      case DPadAction.right:
        setState(() {
          _zone = FocusZone.actions;
          _focusedAction = 0;
        });
        return KeyEventResult.handled;
      case DPadAction.select:
        setState(() => _selectedTab = _focusedTab);
        return KeyEventResult.handled;
      case DPadAction.back:
        return KeyEventResult.handled;
    }
  }

  KeyEventResult _handleActionsZone(DPadAction action) {
    switch (action) {
      case DPadAction.up:
        setState(
          () =>
              _focusedAction = (_focusedAction - 1).clamp(0, _actionCount - 1),
        );
        return KeyEventResult.handled;
      case DPadAction.down:
        setState(
          () =>
              _focusedAction = (_focusedAction + 1).clamp(0, _actionCount - 1),
        );
        return KeyEventResult.handled;
      case DPadAction.left:
        setState(() {
          _zone = FocusZone.tabs;
          _focusedTab = _selectedTab;
        });
        return KeyEventResult.handled;
      case DPadAction.select:
        _handleActionSelect(_focusedAction);
        return KeyEventResult.handled;
      case DPadAction.right:
      case DPadAction.back:
        return KeyEventResult.handled;
    }
  }

  void _handleActionSelect(int action) {
    switch (action) {
      case 0:
        context.push(AppRoutes.editProfile);
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        _logout();
    }
  }

  void _logout() => ref.read(logoutProvider)();

  @override
  Widget build(BuildContext context) {
    return SidebarNavigationHandler(
      rowItemCounts: const [1],
      autofocus: false,
      child: DPadListener(
        autofocus: true,
        onAction: _handleAction,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TabColumn(
                tabs: _tabs,
                selectedTab: _selectedTab,
                focusedTab: _focusedTab,
                isActive: _zone == FocusZone.tabs,
              ),
              const SizedBox(width: 24),
              Expanded(child: _buildPanel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() => switch (_selectedTab) {
    0 => _AccountPanel(
      focusedAction: _zone == FocusZone.actions ? _focusedAction : -1,
      onLogout: _logout,
    ),
    _ => _PlaceholderPanel(label: _tabs[_selectedTab].label),
  };
}

// ─── Tab column ───────────────────────────────────────────────────────────────

class _TabColumn extends StatelessWidget {
  const _TabColumn({
    required this.tabs,
    required this.selectedTab,
    required this.focusedTab,
    required this.isActive,
  });

  final List<SettingsTab> tabs;
  final int selectedTab;
  final int focusedTab;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: tabs
            .asMap()
            .entries
            .map(
              (e) => _TabItem(
                label: e.value.label,
                icon: e.value.icon,
                isSelected: selectedTab == e.key,
                isFocused: isActive && focusedTab == e.key,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isFocused,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    final bg = isFocused
        ? _purple
        : isSelected
        ? _purpleDim
        : Colors.transparent;
    final textColor = (isFocused || isSelected) ? _textPrimary : _textSecondary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: isFocused
            ? Border.all(color: _purple.withValues(alpha: 0.8), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: (isSelected || isFocused)
                    ? FontWeight.w700
                    : FontWeight.w400,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Account panel ────────────────────────────────────────────────────────────

class _AccountPanel extends ConsumerWidget {
  const _AccountPanel({required this.focusedAction, required this.onLogout});

  final int focusedAction;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(meProvider);
    return AsyncUIBuilder(
      asyncValue: userAsyncValue,
      builder: (data) {
        return Container(
          decoration: BoxDecoration(
            color: _bgCard,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'AJUSTES DE CUENTA',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _Avatar(avatarUrl: data.avatarUrl),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      data.name ?? 'Usuario_Game_Spotlight',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _ActionButton(
                    label: 'EDITAR PERFIL',
                    isFocused: focusedAction == 0,
                    color: _purple,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: _divider, height: 1),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _LabelRow(label: 'Idioma de la interfaz'),
                        SizedBox(height: 18),
                        _LabelRow(label: 'Control Parental'),
                        SizedBox(height: 18),
                        _LabelRow(label: 'Gestión de Suscripción'),
                        SizedBox(height: 18),
                        _LabelRow(label: 'Dispositivos Vinculados'),
                        SizedBox(height: 18),
                        _LabelRow(label: 'Seguridad de la Cuenta'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Control Parental',
                          style: TextStyle(
                            color: _textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Desactivado — restringe el acceso a juegos con clasificación parental.',
                          style: TextStyle(color: _textSecondary, fontSize: 11),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Dispositivos Vinculados',
                          style: TextStyle(
                            color: _textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ActionButton(
                          label: 'Ver Todos',
                          isFocused: focusedAction == 1,
                          color: _purpleDim,
                        ),
                        const SizedBox(height: 8),
                        _ActionButton(
                          label: 'Cambiar Contraseña',
                          isFocused: focusedAction == 2,
                          color: _purpleDim,
                        ),
                        const SizedBox(height: 8),
                        _ActionButton(
                          label: 'Cerrar Sesión',
                          isFocused: focusedAction == 3,
                          color: _red,
                          onTap: onLogout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Auxiliares ───────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(avatarUrl ?? ''),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
        border: Border.all(color: _purple, width: 2),
        color: _purpleDim,
      ),
      child: avatarUrl == null
          ? const Icon(Icons.person, color: _textPrimary, size: 26)
          : null,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.isFocused,
    required this.color,
    this.onTap,
  });

  final String label;
  final bool isFocused;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFocused ? Colors.white : Colors.transparent,
          width: 2,
        ),
        boxShadow: isFocused
            ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 10)]
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: _textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: _textPrimary, fontSize: 13),
    );
  }
}

class _PlaceholderPanel extends StatelessWidget {
  const _PlaceholderPanel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Próximamente...',
            style: TextStyle(color: _textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
