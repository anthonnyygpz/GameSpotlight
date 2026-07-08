import 'package:gamespotlight/core/domain/trailers/entities/trailer_entity.dart';

final List<TrailerEntity> mockTrailers = [
  // Grand Theft Auto VI (idJuego: 1) — Rockstar Games | Nov 2026
  const TrailerEntity(
    idTrailer: '1',
    idJuego: '1',
    titulo: 'Grand Theft Auto VI — Tráiler Oficial #1',
    urlVideo: 'https://www.youtube.com/watch?v=QdBZY2fkU-0',
    urlPoster: 'https://img.youtube.com/vi/QdBZY2fkU-0/maxresdefault.jpg',
    duracion: '1:31',
    orden: '1',
    createdAt: '2023-12-04T18:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '2',
    idJuego: '1',
    titulo: 'Grand Theft Auto VI — Tráiler Oficial #2',
    urlVideo: 'https://www.youtube.com/watch?v=VQRLujxTm3c',
    urlPoster: 'https://img.youtube.com/vi/VQRLujxTm3c/maxresdefault.jpg',
    duracion: '2:47',
    orden: '2',
    createdAt: '2025-05-06T09:30:00Z',
  ),

  // Marvel's Wolverine (idJuego: 2) — Insomniac Games | Sep 2026
  const TrailerEntity(
    idTrailer: '3',
    idJuego: '2',
    titulo: "Marvel's Wolverine — Tráiler de Gameplay",
    urlVideo: 'https://www.youtube.com/watch?v=s3pDMUWlA6I',
    urlPoster: 'https://img.youtube.com/vi/s3pDMUWlA6I/maxresdefault.jpg',
    duracion: '2:30',
    orden: '1',
    createdAt: '2025-09-24T17:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '4',
    idJuego: '2',
    titulo: "Marvel's Wolverine — Tráiler Extendido de Gameplay",
    urlVideo: 'https://www.youtube.com/watch?v=OiBo_NgYI5Q',
    urlPoster: 'https://img.youtube.com/vi/OiBo_NgYI5Q/maxresdefault.jpg',
    duracion: '9:15',
    orden: '2',
    createdAt: '2026-06-02T17:00:00Z',
  ),

  // Resident Evil Requiem (idJuego: 3) — Capcom | Feb 2026
  const TrailerEntity(
    idTrailer: '5',
    idJuego: '3',
    titulo: 'Resident Evil Requiem — Tráiler de Revelación Oficial',
    urlVideo: 'https://www.youtube.com/watch?v=paigphanR9o',
    urlPoster: 'https://img.youtube.com/vi/paigphanR9o/maxresdefault.jpg',
    duracion: '3:44',
    orden: '1',
    createdAt: '2025-06-06T20:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '6',
    idJuego: '3',
    titulo: 'Resident Evil Requiem — Tráiler de Lanzamiento',
    urlVideo: 'https://www.youtube.com/watch?v=9lrThxCoznw',
    urlPoster: 'https://img.youtube.com/vi/9lrThxCoznw/maxresdefault.jpg',
    duracion: '2:55',
    orden: '2',
    createdAt: '2026-02-27T08:00:00Z',
  ),

  // Ghost of Yōtei (idJuego: 4) — Sucker Punch | Oct 2025
  const TrailerEntity(
    idTrailer: '7',
    idJuego: '4',
    titulo: 'Ghost of Yōtei — Tráiler de Anuncio',
    urlVideo: 'https://www.youtube.com/watch?v=7z7kqwuf0a8',
    urlPoster: 'https://img.youtube.com/vi/7z7kqwuf0a8/maxresdefault.jpg',
    duracion: '3:09',
    orden: '1',
    createdAt: '2024-09-24T17:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '8',
    idJuego: '4',
    titulo: 'Ghost of Yōtei — Tráiler de Lanzamiento',
    urlVideo: 'https://www.youtube.com/watch?v=sLcksHR30UA',
    urlPoster: 'https://img.youtube.com/vi/sLcksHR30UA/maxresdefault.jpg',
    duracion: '2:42',
    orden: '2',
    createdAt: '2025-09-25T17:00:00Z',
  ),

  // Death Stranding 2: On the Beach (idJuego: 5) — Kojima Productions | Jun 2025
  const TrailerEntity(
    idTrailer: '9',
    idJuego: '5',
    titulo: 'Death Stranding 2 — Tráiler de Anuncio State of Play',
    urlVideo: 'https://www.youtube.com/watch?v=wbLstJHlC4U',
    urlPoster: 'https://img.youtube.com/vi/wbLstJHlC4U/maxresdefault.jpg',
    duracion: '9:40',
    orden: '1',
    createdAt: '2024-01-31T18:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '10',
    idJuego: '5',
    titulo: 'Death Stranding 2 — Tráiler Final',
    urlVideo: 'https://www.youtube.com/watch?v=PDXWJC1Lvh8',
    urlPoster: 'https://img.youtube.com/vi/PDXWJC1Lvh8/maxresdefault.jpg',
    duracion: '3:18',
    orden: '2',
    createdAt: '2025-06-26T07:00:00Z',
  ),

  // Gears of War: E-Day (idJuego: 6) — The Coalition | Oct 2026
  const TrailerEntity(
    idTrailer: '11',
    idJuego: '6',
    titulo: 'Gears of War: E-Day — Tráiler de Anuncio Oficial',
    urlVideo: 'https://www.youtube.com/watch?v=EC20gLfUHeA',
    urlPoster: 'https://img.youtube.com/vi/EC20gLfUHeA/maxresdefault.jpg',
    duracion: '2:58',
    orden: '1',
    createdAt: '2024-06-09T17:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '12',
    idJuego: '6',
    titulo: 'Gears of War: E-Day — Tráiler de Gameplay',
    urlVideo: 'https://www.youtube.com/watch?v=yAWz9IIQvt0',
    urlPoster: 'https://img.youtube.com/vi/yAWz9IIQvt0/maxresdefault.jpg',
    duracion: '3:22',
    orden: '2',
    createdAt: '2026-06-09T17:00:00Z',
  ),

  // God of War: Laufey (idJuego: 7) — Santa Monica Studio | 2027
  const TrailerEntity(
    idTrailer: '13',
    idJuego: '7',
    titulo: 'God of War Laufey — Tráiler de Gameplay State of Play',
    urlVideo: 'https://www.youtube.com/watch?v=HLMX2w3cwuE',
    urlPoster: 'https://img.youtube.com/vi/HLMX2w3cwuE/maxresdefault.jpg',
    duracion: '4:48',
    orden: '1',
    createdAt: '2026-06-02T17:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '14',
    idJuego: '7',
    titulo: 'God of War Laufey — Gameplay Reveal Extendido (4K)',
    urlVideo: 'https://www.youtube.com/watch?v=MCg5A1Jupi0',
    urlPoster: 'https://img.youtube.com/vi/MCg5A1Jupi0/maxresdefault.jpg',
    duracion: '20:14',
    orden: '2',
    createdAt: '2026-06-02T17:30:00Z',
  ),

  // Persona 6 (idJuego: 8) — Atlus | TBA 2027
  const TrailerEntity(
    idTrailer: '15',
    idJuego: '8',
    titulo: 'Persona 6 — Tráiler Teaser Oficial',
    urlVideo: 'https://www.youtube.com/watch?v=OaWZAAQ6Qrs',
    urlPoster: 'https://img.youtube.com/vi/OaWZAAQ6Qrs/maxresdefault.jpg',
    duracion: '1:45',
    orden: '1',
    createdAt: '2026-06-09T17:00:00Z',
  ),

  // Final Fantasy VII Revelation (idJuego: 9) — Square Enix | Spring 2027
  const TrailerEntity(
    idTrailer: '16',
    idJuego: '9',
    titulo: 'Final Fantasy VII Revelation — Tráiler de Revelación',
    urlVideo: 'https://www.youtube.com/watch?v=VMI45v9fbeI',
    urlPoster: 'https://img.youtube.com/vi/VMI45v9fbeI/maxresdefault.jpg',
    duracion: '3:12',
    orden: '1',
    createdAt: '2026-06-05T19:00:00Z',
  ),

  // Clair Obscur: Expedition 33 (idJuego: 10) — Sandfall Interactive | Apr 2025
  // GOTY 2025, juego indie que barrió en The Game Awards
  const TrailerEntity(
    idTrailer: '17',
    idJuego: '10',
    titulo: 'Clair Obscur: Expedition 33 — Tráiler de Revelación',
    urlVideo: 'https://www.youtube.com/watch?v=2VaLOc1FpSo',
    urlPoster: 'https://img.youtube.com/vi/2VaLOc1FpSo/maxresdefault.jpg',
    duracion: '2:36',
    orden: '1',
    createdAt: '2024-06-10T20:00:00Z',
  ),
  const TrailerEntity(
    idTrailer: '18',
    idJuego: '10',
    titulo: 'Clair Obscur: Expedition 33 — Tráiler de Lanzamiento',
    urlVideo: 'https://www.youtube.com/watch?v=ZHqPPFRGC8Y',
    urlPoster: 'https://img.youtube.com/vi/ZHqPPFRGC8Y/maxresdefault.jpg',
    duracion: '3:01',
    orden: '2',
    createdAt: '2025-04-24T07:00:00Z',
  ),
];
