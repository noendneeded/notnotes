import 'package:flutter/material.dart';
import 'package:notnotes/ui/widgets/default_box_shadow/default_box_shadow.dart';

class FocusableContainerWidget extends StatefulWidget {
  const FocusableContainerWidget({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  final Widget child;
  final double? height;
  final double? width;

  @override
  State<FocusableContainerWidget> createState() =>
      _FocusableContainerWidgetState();
}

class _FocusableContainerWidgetState extends State<FocusableContainerWidget> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,

      ///
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,

      decoration: BoxDecoration(
        ///
        border: _hasFocus ? Border.all(color: Colors.black, width: 3) : null,
        borderRadius: BorderRadius.circular(16),

        color: _hasFocus
            ? Theme.of(context).highlightColor
            : Theme.of(context).scaffoldBackgroundColor,

        boxShadow: _hasFocus ? [] : [DefaultBoxShadow.get(context)],
      ),

      child: Focus(
        focusNode: _focusNode,
        child: widget.child,
      ),
    );
  }
}
