import 'package:flutter/material.dart';
import 'package:gamespotlight/core/widgets/card_glass.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

const _qrData = 'lorem ipsum dolor sit amet';
const _qrSize = 140.0;

class MoreFormLogin extends StatelessWidget {
  const MoreFormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          _QrLoginCard(),
          _ProviderLoginCard(
            asset: 'assets/google_icon.png',
            label: 'INICIAR CON GOOGLE',
            onPressed: () {},
          ),
          _ProviderLoginCard(
            asset: 'assets/play_station_icon.png',
            label: 'INICIAR CON PLAYSTATION',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _QrLoginCard extends StatelessWidget {
  const _QrLoginCard();

  @override
  Widget build(BuildContext context) {
    return CardGlass(
      padding: const EdgeInsets.all(15),
      child: Row(
        spacing: 10,
        children: [
          _QrCode(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'INICIAR SESIÓN CON CÓDIGO QR',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Escanea con tu móvil',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QrCode extends StatelessWidget {
  const _QrCode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _qrSize,
      height: _qrSize,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: PrettyQrView.data(
        data: _qrData,
        decoration: const PrettyQrDecoration(
          shape: PrettyQrShape.custom(
            PrettyQrSquaresSymbol(),
            finderPattern: PrettyQrSmoothSymbol(),
          ),
          quietZone: PrettyQrQuietZone.standard,
        ),
      ),
    );
  }
}

class _ProviderLoginCard extends StatelessWidget {
  const _ProviderLoginCard({
    required this.asset,
    required this.label,
    this.onPressed,
  });

  final String asset;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CardGlass(
      onPressed: onPressed,
      padding: const EdgeInsets.all(15),
      child: Row(
        spacing: 15,
        children: [
          Image.asset(asset, width: 40),
          Text(
            label,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
