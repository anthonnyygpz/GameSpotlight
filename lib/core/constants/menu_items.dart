import 'package:flutter/material.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/models/nav_item.dart';

const globalNavItems = [
  NavItem(icon: Icons.home_rounded, label: 'INICIO', route: AppRoutes.home),
  NavItem(
    icon: Icons.rocket_launch_rounded,
    label: 'PRÓXIMOS\nLANZAMIENTOS',
    route: AppRoutes.upcomingReleases,
  ),
  NavItem(
    icon: Icons.play_circle_rounded,
    label: 'TRAILERS\nEXCLUSIVOS',
    route: AppRoutes.exclusiveTrailers,
  ),
  NavItem(
    icon: Icons.sports_esports_rounded,
    label: 'GÉNEROS',
    route: AppRoutes.genres,
  ),
  NavItem(icon: Icons.tv_rounded, label: 'PLATAFORMAS', route: ''),
  NavItem(
    icon: Icons.favorite_rounded,
    label: 'FAVORITOS',
    route: AppRoutes.favorites,
  ),
  NavItem(
    icon: Icons.settings_rounded,
    label: 'AJUSTES',
    route: AppRoutes.settings,
  ),
];
