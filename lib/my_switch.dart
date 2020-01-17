import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const MySwitch({
    Key key,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;
  bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: value ? Alignment.centerRight : Alignment.centerLeft,
            end: value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            value = !value;
            value == false ? widget.onChanged(false) : widget.onChanged(true);
          },
          child: Container(
            width: 74,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(color: Color(0Xff9DA2AC), width: 1)),
            child: Stack(
              children: <Widget>[
                background(),
                _getContent(),
                ball(),
              ],
            ),
          ),
        );
      },
    );
  }

  Align background() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 70,
        height: 21,
        decoration: BoxDecoration(
            color: value ? Color(0xff2E70B5) : Color(0xff9DA2AC),
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
    );
  }

  Align ball() {
    return Align(
      alignment: _circleAnimation.value,
      child: Container(
        width: 23,
        height: 23,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }

  _getContent() {
    if (value) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "OPEN",
            style: TextStyle(
              height: 1.2,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                  color: Color(0xff2E70B5),
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5.0,
                  color: Color(0xff22FFE4),
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                  color: Color(0xff2E70B5),
                ),
              ],
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            "CLOSED",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
