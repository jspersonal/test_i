import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: _boxDecoration(),
      child: Stack(
        children: [
          _HeaderIcon(),

          this.child
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background-login.png'),
            fit: BoxFit.cover),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
          ],
          // stops: [0.1, 0.4, 0.7, 0.9],
        ),
      );
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 100),
        // padding: EdgeInsets.symmetric(vertical: 150),
        child: SvgPicture.asset(
          'assets/images/logo-infomercados.svg',
          width: 150,
        ),
      ),
    );
  }
}
