import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_tv/core/widgets/button_circle_avatar.dart';
import 'package:game_tv/core/widgets/custom_icon_button.dart';
import 'package:game_tv/features/home/views/widgets/logo.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final FocusScopeNode _navbarScope = FocusScopeNode();

  @override
  void dispose() {
    _navbarScope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 10),
      child: FocusScope(
        node: FocusScopeNode(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Logo(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIconButton(icon: Icons.search, onPressed: () {}),
                CustomIconButton(
                  onPressed: () {},
                  icon: CupertinoIcons.bell_solid,
                ),
                ButtonCircleAvatar(
                  onPressed: () {},
                  backgroundColor: Colors.deepPurple,
                  focusedBorderColor: Colors.white,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
