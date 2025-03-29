import 'package:flutter/material.dart';

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  late final TextEditingController _controller1;
  late final TextEditingController _controller2;
  late final TextEditingController _controller3;

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Innner Shadow"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              fieldHeight: MediaQuery.sizeOf(context).height * .07,
              controller: _controller1,
              hintText: "Side Shadow",
              focusedBorder: Border.all(color: Colors.green, width: 2.0),
              enabledBorder: Border.all(color: Colors.grey, width: 1.0),
              shadowBegin: Alignment.centerLeft,
              shadowEnd: Alignment.centerRight,
            ),
            CustomTextField(
              fieldHeight: MediaQuery.sizeOf(context).height * .1,
              controller: _controller2,
              hintText: "Bottom Shadow",
              focusedBorder: Border.all(color: Colors.indigo, width: 2.0),
              enabledBorder: Border.all(color: Colors.grey, width: 1.0),
              shadowBegin: Alignment.topCenter,
              shadowEnd: Alignment.bottomCenter,
              isCustomShadow: false,
            ),
            CustomTextField(
              fieldHeight: MediaQuery.sizeOf(context).height * .17,
              controller: _controller3,
              hintText: "Gradient Shadow",
              focusedBorder: Border.all(color: Colors.cyan, width: 2.0),
              enabledBorder: Border.all(color: Colors.grey, width: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.fieldHeight,
    required this.controller,
    this.fillColor = Colors.white,
    this.contentpadding = 5.0,
    this.enabledBorder,
    this.focusedBorder,
    this.hintText,
    this.shadowEnd = Alignment.bottomRight,
    this.shadowBegin = Alignment.topLeft,
    this.isCustomShadow = true,
    this.fillRatio = 6,
    this.shadowColors = const <Color>[
      Color(0xFFFFFFFF),
      Color(0xFFFAFAFA),
      Color(0xFFE0E0E0),
      Color(0xFFBDBDBD),
    ],
  });

  final double fieldHeight;
  final TextEditingController controller;
  final Color fillColor;
  final BoxBorder? focusedBorder;
  final BoxBorder? enabledBorder;
  final double contentpadding;
  final String? hintText;

  final AlignmentGeometry shadowBegin;
  final AlignmentGeometry shadowEnd;
  final List<Color> shadowColors;
  final bool isCustomShadow;
  final int fillRatio;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showBorder = false;

  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();

    _focusNode.addListener(
      () {
        setState(
          () {
            showBorder = _focusNode.hasFocus;
          },
        );
      },
    );
    super.initState();
  }

  BoxBorder? get border {
    BoxBorder? border =
        showBorder ? widget.focusedBorder : widget.enabledBorder;

    return border;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.hintText ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        Container(
          height: widget.fieldHeight,
          margin: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          padding: EdgeInsets.all(widget.contentpadding),
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(15.0),
            color: widget.fillColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                spreadRadius: 1.0,
                blurRadius: 15.0,
                color: Colors.grey.shade400,
                offset: const Offset(4, 4),
              ),
              const BoxShadow(
                spreadRadius: 1.0,
                blurRadius: 15.0,
                color: Colors.white,
                offset: Offset(-4, -4),
              ),
            ],
            gradient: LinearGradient(
              colors: widget.isCustomShadow
                  ? widget.shadowColors
                  : <Color>[
                      for (int i = 0; i < widget.fillRatio; i++) ...{
                        widget.fillColor,
                      },
                      Colors.grey.shade50,
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                      Colors.grey.shade400,
                    ],
              begin: widget.shadowBegin,
              end: widget.shadowEnd,
            ),
          ),
          child: Focus(
            focusNode: _focusNode,
            child: TextFormField(
              controller: widget.controller,
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
