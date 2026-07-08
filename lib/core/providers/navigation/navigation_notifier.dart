import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/menu_items.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_state.dart';

class NavigationNotifier extends Notifier<NavigationState> {
  ScrollController? _activeMainScroll;
  List<ScrollController> _activeRowScrolls = [];

  final Map<int, int> _savedCol = {};

  // Parámetros dinámicos de la topología actual
  double _cardWidth = AppConstants.cardScrollExtent;
  double _rowHeight = 185.0;
  double _heroHeight = 320.0;
  bool _hasHero = true;
  bool _isGridTopology = false;

  @override
  NavigationState build() {
    return NavigationState();
  }

  // Protocolo de inyección táctica dinámico
  void attachControllers(
    ScrollController main,
    List<ScrollController> rows, {
    bool hasHero = true,
    double rowHeight = 185.0,
    double heroHeight = 320.0,
    bool isGrid = false,
  }) {
    _activeMainScroll = main;
    _activeRowScrolls = rows;
    _hasHero = hasHero;
    _rowHeight = rowHeight;
    _heroHeight = heroHeight;
    _isGridTopology = isGrid;
  }

  void moveRow(int delta, List<int> rowItemCounts) {
    if (state.col == -1) {
      final newIndex = (state.navIndex + delta).clamp(
        0,
        globalNavItems.length - 1,
      );
      if (newIndex != state.navIndex) {
        state = state.copyWith(navIndex: newIndex);
      }
      return;
    }

    if (rowItemCounts.isEmpty) return;

    final validCurrentRow = state.row.clamp(0, rowItemCounts.length - 1);
    final newRow = (validCurrentRow + delta).clamp(0, rowItemCounts.length - 1);

    if (newRow == state.row && validCurrentRow == state.row) return;

    int targetCol;

    if (_isGridTopology) {
      // MODO CUADRÍCULA (PlatformsScreen): Mantiene la columna actual (caída en línea recta)
      targetCol = state.col.clamp(0, rowItemCounts[newRow] - 1);
    } else {
      // MODO CARRUSEL (HomeScreen): Guarda la posición y regresa al inicio (0) o a donde se quedó
      _savedCol[validCurrentRow] = state.col;
      targetCol = (_savedCol[newRow] ?? 0).clamp(0, rowItemCounts[newRow] - 1);
    }

    state = state.copyWith(row: newRow, col: targetCol);

    _scrollToRow(newRow);
    _scrollRowToCol(newRow, targetCol);
  }

  void moveCol(int delta, List<int> rowItemCounts) {
    if (rowItemCounts.isEmpty) return;

    final validRow = state.row.clamp(0, rowItemCounts.length - 1);
    final maxCol = rowItemCounts[validRow] - 1;
    final newCol = (state.col + delta).clamp(-1, maxCol);

    if (newCol == state.col && validRow == state.row) return;

    int newNavIndex = state.navIndex;
    int newHeroIndex = state.heroSlideIndex;

    if (state.col == -1 && newCol >= 0) {
      newNavIndex = state.activeRouteIndex;
    }

    if (_hasHero && newCol >= 0 && validRow == 0) {
      newHeroIndex = newCol.clamp(0, maxCol);
    }

    state = state.copyWith(
      row: validRow,
      col: newCol,
      navIndex: newNavIndex,
      heroSlideIndex: newHeroIndex,
    );

    if (newCol >= 0) {
      _scrollRowToCol(validRow, newCol);
    }
  }

  void onSelect(Function(int) onNavigate) {
    if (state.col == -1) {
      state = state.copyWith(activeRouteIndex: state.navIndex);
      onNavigate(state.navIndex);
    } else {
      debugPrint(
        'Ejecutando protocolo en objetivo: Fila ${state.row}, Columna ${state.col}',
      );
    }
  }

  void _scrollToRow(int targetRow) {
    if (_activeMainScroll == null || !_activeMainScroll!.hasClients) return;

    double offset = 0.0;
    if (_hasHero) {
      offset = targetRow == 0
          ? 0
          : _heroHeight + (targetRow - 1) * _rowHeight - 60;
    } else {
      // Cálculo de scroll vertical limpio para pantallas sin HeroBanner
      offset = targetRow * _rowHeight;
      if (targetRow > 0)
        offset -= 40; // Margen de respiro para que no toque el borde exacto
    }

    _activeMainScroll!.animateTo(
      offset.clamp(0.0, _activeMainScroll!.position.maxScrollExtent),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _scrollRowToCol(int targetRow, int targetCol) {
    if (_hasHero && targetRow == 0) return;

    if (targetRow < 0 || targetRow >= _activeRowScrolls.length) return;
    final controller = _activeRowScrolls[targetRow];

    if (!controller.hasClients) return;

    final targetOffset = (targetCol * _cardWidth - 20.0).clamp(
      0.0,
      controller.position.maxScrollExtent,
    );

    controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  void syncActiveRoute() {
    if (state.col == -1) {
      state = state.copyWith(activeRouteIndex: state.navIndex);
    }
  }

  void resetPosition() {
    state = state.copyWith(row: 0, col: 0);
  }

  void syncWithRoute(String route) {
    final index = globalNavItems.indexWhere((item) => item.route == route);

    if (index != -1 && state.activeRouteIndex != index) {
      state = state.copyWith(
        navIndex: index,
        activeRouteIndex: index,
        row: 0,
        col: 0,
      );

      _scrollToRow(0);
      _savedCol.clear();

      for (final controller in _activeRowScrolls) {
        if (controller.hasClients) {
          controller.jumpTo(0);
        }
      }
    }
  }

  void jumpTo(int targetRow, int targetCol) {
    state = state.copyWith(row: targetRow, col: targetCol);
    _savedCol[targetRow] = targetCol;
    _scrollToRow(targetRow);
    _scrollRowToCol(targetRow, targetCol);
  }
}

final navigationProvider =
    NotifierProvider<NavigationNotifier, NavigationState>(() {
      return NavigationNotifier();
    });
