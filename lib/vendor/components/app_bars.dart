import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// START--------------- BNBCustom01Painter ----------------------
class BNBCustom01Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.transparent, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BNBCustom01 extends StatefulWidget {
  @override
  _BNBCustom01State createState() => _BNBCustom01State();
}

class _BNBCustom01State extends State<BNBCustom01> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: BNBCustom01Painter(),
            ),
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.orange,
                child: Icon(Icons.shopping_basket),
                elevation: 0.1,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.restaurant_menu),
                    onPressed: () {},
                  ),
                  Container(width: size.width * 0.20),
                  IconButton(
                    icon: Icon(Icons.bookmark),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// END--------------- BNBCustom01Painter ----------------------

// START--------------- CustomBottomNavBar01 ----------------------
class CustomBottomNavBar01 extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavBar01({
    this.defaultSelectedIndex = 0,
    @required this.iconList,
    @required this.onChange,
  });

  @override
  _CustomBottomNavBar01State createState() => _CustomBottomNavBar01State();
}

class _CustomBottomNavBar01State extends State<CustomBottomNavBar01> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem01(_iconList[i], i));
    }
    return Row(children: _navBarItemList);
  }

  Widget buildNavBarItem01(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onChange(index);
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _iconList.length,
        child: Center(
          child: FaIcon(
            icon,
            color: index == _selectedIndex ? Colors.black : Colors.grey,
          ),
        ),
        decoration: index == _selectedIndex
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: Colors.grey[700])),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.015),
                    Colors.grey.withOpacity(0.3)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              )
            : BoxDecoration(),
      ),
    );
  }
}
// END--------------- CustomBottomNavBar01 ----------------------