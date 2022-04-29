import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController textController;
  final ValueNotifier<bool> showFilters;
  final void Function() onPressed;

  const SearchBar({
    required this.textController,
    required this.showFilters,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Focus(
            onFocusChange: (value) => setState(() {}),
            child: InputDecorator(
              isFocused: textFocus.hasFocus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                label: Text('Search'),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: textFocus,
                      controller: widget.textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        widget.showFilters.value = !widget.showFilters.value,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: widget.showFilters,
                      builder: (context, value, child) {
                        return Icon(
                          Icons.filter_alt,
                          color: value ? const Color(0xFFF26522) : Colors.grey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: widget.onPressed,
          iconSize: 25,
          color: Colors.grey.shade700,
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    textFocus.dispose();
  }
}
