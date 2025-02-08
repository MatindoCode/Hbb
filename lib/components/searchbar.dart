import 'package:flutter/material.dart';

class GlowingSearchField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const GlowingSearchField({
    super.key,
    this.hintText = "Search...",
    this.onChanged,
    this.controller,
  });

  @override
  State<GlowingSearchField> createState() => _GlowingSearchFieldState();
}

class _GlowingSearchFieldState extends State<GlowingSearchField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
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
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.7),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
      ),
      width: double.infinity,
      height: 50,
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}