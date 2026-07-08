import 'package:gamespotlight/core/domain/trailer_categories/entity/trailer_categories_entity.dart';

final List<TrailerCategoryEntity> mockTrailerCategories = [
  // ---------------------------------------------------------
  // CATEGORÍA 1: PRÓXIMO LANZAMIENTO
  // Juegos aún sin salir o muy recientes (2026-2027)
  // trailerId = id de categoría, categoryId = id del juego/trailer
  // ---------------------------------------------------------
  const TrailerCategoryEntity(
    trailerId: '1',
    categoryId: '1',
  ), // GTA VI (Nov 2026)
  const TrailerCategoryEntity(
    trailerId: '1',
    categoryId: '2',
  ), // Marvel's Wolverine (Sep 2026)
  const TrailerCategoryEntity(
    trailerId: '1',
    categoryId: '6',
  ), // Gears of War: E-Day (Oct 2026)
  const TrailerCategoryEntity(
    trailerId: '1',
    categoryId: '7',
  ), // God of War: Laufey (2027)
  const TrailerCategoryEntity(
    trailerId: '1',
    categoryId: '8',
  ), // Persona 6 (TBA 2027)
  const TrailerCategoryEntity(
    trailerId: '1',
    categoryId: '9',
  ), // FF VII Revelation (Spring 2027)
  // ---------------------------------------------------------
  // CATEGORÍA 2: NUEVOS
  // Lanzamientos recientes (2025-2026)
  // ---------------------------------------------------------
  const TrailerCategoryEntity(
    trailerId: '2',
    categoryId: '3',
  ), // Resident Evil Requiem (Feb 2026)
  const TrailerCategoryEntity(
    trailerId: '2',
    categoryId: '4',
  ), // Ghost of Yōtei (Oct 2025)
  const TrailerCategoryEntity(
    trailerId: '2',
    categoryId: '5',
  ), // Death Stranding 2 (Jun 2025)
  const TrailerCategoryEntity(
    trailerId: '2',
    categoryId: '10',
  ), // Clair Obscur: Expedition 33 (Apr 2025)
  // ---------------------------------------------------------
  // CATEGORÍA 3: MEJOR VALORADO
  // Juegos aclamados por la crítica o con más hype
  // ---------------------------------------------------------
  const TrailerCategoryEntity(
    trailerId: '3',
    categoryId: '10',
  ), // Clair Obscur (GOTY 2025)
  const TrailerCategoryEntity(
    trailerId: '3',
    categoryId: '5',
  ), // Death Stranding 2 (nominado TGA 2025)
  const TrailerCategoryEntity(
    trailerId: '3',
    categoryId: '4',
  ), // Ghost of Yōtei (nominado TGA 2025)
  const TrailerCategoryEntity(
    trailerId: '3',
    categoryId: '3',
  ), // Resident Evil Requiem
  const TrailerCategoryEntity(
    trailerId: '3',
    categoryId: '2',
  ), // Marvel's Wolverine
  const TrailerCategoryEntity(trailerId: '3', categoryId: '1'), // GTA VI
  // ---------------------------------------------------------
  // CATEGORÍA 4: TRÁILERS EXCLUSIVOS
  // Reveals y gameplays destacados de showcases
  // ---------------------------------------------------------
  const TrailerCategoryEntity(
    trailerId: '4',
    categoryId: '7',
  ), // God of War: Laufey (State of Play)
  const TrailerCategoryEntity(
    trailerId: '4',
    categoryId: '8',
  ), // Persona 6 (Xbox Showcase 2026)
  const TrailerCategoryEntity(
    trailerId: '4',
    categoryId: '9',
  ), // FF VII Revelation (Summer Game Fest)
  const TrailerCategoryEntity(
    trailerId: '4',
    categoryId: '6',
  ), // Gears of War: E-Day (Xbox Showcase)
  const TrailerCategoryEntity(
    trailerId: '4',
    categoryId: '2',
  ), // Marvel's Wolverine (State of Play)
];
