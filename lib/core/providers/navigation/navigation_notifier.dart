import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/menu_items.dart';
import 'package:game_tv/core/providers/navigation/navigation_state.dart';

class NavigationNotifier extends Notifier<NavigationState> {
  final ScrollController mainScroll = ScrollController();
  final List<ScrollController> rowScrolls = List.generate(
    5,
    (_) => ScrollController(),
  );

  final Map<int, int> _savedCol = {};

  static const double _cardWidth = 222.0;
  static const double _rowHeight = 185.0;
  static const double _heroHeight = 320.0;

  @override
  NavigationState build() {
    ref.onDispose(() {
      mainScroll.dispose();
      for (final c in rowScrolls) {
        c.dispose();
      }
    });
    return NavigationState();
  }

  void moveRow(int delta, List<int> rowItemCounts) {
    if (state.col == -1) {
      final newIndex = (state.navIndex + delta).clamp(
        0,
        6,
      ); // Asegure su _navItemsLength
      if (newIndex != state.navIndex) {
        state = state.copyWith(navIndex: newIndex);
      }
      return;
    }

    if (rowItemCounts.isEmpty) return;

    // Recalibración: Asegura que la fila actual sea válida en la nueva pantalla
    final validCurrentRow = state.row.clamp(0, rowItemCounts.length - 1);
    final newRow = (validCurrentRow + delta).clamp(0, rowItemCounts.length - 1);

    if (newRow == state.row && validCurrentRow == state.row) return;

    _savedCol[validCurrentRow] = state.col;
    final restoredCol = (_savedCol[newRow] ?? 0).clamp(
      0,
      rowItemCounts[newRow] - 1,
    );

    state = state.copyWith(row: newRow, col: restoredCol);

    _scrollToRow(newRow);
    _scrollRowToCol(newRow, restoredCol);
  }

  void moveCol(int delta, List<int> rowItemCounts) {
    if (rowItemCounts.isEmpty) return;

    // Recalibración: Evita buscar índices inexistentes al entrar desde el Sidebar
    final validRow = state.row.clamp(0, rowItemCounts.length - 1);

    final maxCol = rowItemCounts[validRow] - 1;
    final newCol = (state.col + delta).clamp(-1, maxCol);

    if (newCol == state.col && validRow == state.row) return;

    int newNavIndex = state.navIndex;
    int newHeroIndex = state.heroSlideIndex;

    if (state.col == -1 && newCol >= 0) {
      newNavIndex = state.activeRouteIndex;
    }

    if (newCol >= 0 && validRow == 0) {
      newHeroIndex = newCol.clamp(
        0,
        maxCol,
      ); // Asumiendo máximo 3 slides en hero
    }

    state = state.copyWith(
      row:
          validRow, // Actualizamos la fila si fue corregida por la matriz local
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
    double offset = targetRow == 0
        ? 0
        : _heroHeight + (targetRow - 1) * _rowHeight - 60;
    mainScroll.animateTo(
      offset.clamp(0.0, mainScroll.position.maxScrollExtent),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _scrollRowToCol(int targetRow, int targetCol) {
    if (targetRow == 0) return;
    final controller = rowScrolls[targetRow - 1];
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

      // Protocolo de restauración física de scroll vertical
      _scrollToRow(0);

      // Limpieza de memoria de navegación horizontal
      _savedCol.clear();
      for (final controller in rowScrolls) {
        if (controller.hasClients) {
          controller.jumpTo(0);
        }
      }
    }
  }
}

final navigationProvider =
    NotifierProvider<NavigationNotifier, NavigationState>(() {
      return NavigationNotifier();
    });
