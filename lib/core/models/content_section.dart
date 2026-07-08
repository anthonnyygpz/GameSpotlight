import 'package:flutter/material.dart';
import 'package:gamespotlight/core/models/row_data.dart';

sealed class ContentSection {
  const ContentSection();
  RowData get data;
}

class HeaderSection extends ContentSection {
  const HeaderSection({required this.widget, required this._data});

  final Widget widget;
  final RowData _data;

  @override
  RowData get data => _data;
}

class RowSection extends ContentSection {
  const RowSection(this.data);

  @override
  final RowData data;
}

List<ContentSection> visibleSections(List<ContentSection> all) {
  return all
      .where(
        (s) => switch (s) {
          HeaderSection() => true,
          RowSection(:final data) => data.items.isNotEmpty,
        },
      )
      .toList();
}
