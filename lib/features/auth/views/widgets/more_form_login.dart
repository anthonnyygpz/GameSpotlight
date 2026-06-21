import 'package:flutter/material.dart';
import 'package:game_tv/features/auth/views/widgets/card_glass.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class MoreFormLogin extends StatefulWidget {
  const MoreFormLogin({super.key});

  @override
  State<MoreFormLogin> createState() => _MoreFormLoginState();
}

class _MoreFormLoginState extends State<MoreFormLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          CardGlass(
            padding: const EdgeInsets.all(15),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: PrettyQrView.data(
                    data: 'lorem ipsum dolor sit amet',
                    decoration: const PrettyQrDecoration(
                      shape: PrettyQrShape.custom(
                        PrettyQrSquaresSymbol(),
                        finderPattern: PrettyQrSmoothSymbol(),
                      ),
                      quietZone: PrettyQrQuietZone.standard,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'INICIAR SESION CON CODIGO QR',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const Text(
                        'Escanea con tu movil',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          CardGlass(
            onPressed: () {},
            padding: const EdgeInsets.all(15),
            child: Row(
              spacing: 15,
              children: [
                Image.asset('assets/google_icon.png', width: 40),
                Text(
                  'INICIAR CON GOOGLE',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),

          CardGlass(
            onPressed: () {},
            padding: const EdgeInsets.all(15),
            child: Row(
              spacing: 15,
              children: [
                Image.asset('assets/play_station_icon.png', width: 40),
                Text(
                  'INICIAR CON PLAYSTATION',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
