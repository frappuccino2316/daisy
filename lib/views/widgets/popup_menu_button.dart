import 'package:flutter/material.dart';

@immutable
class CustomPopupMenuButton extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> menuList;
  final Function popupMenuSelected;

  const CustomPopupMenuButton(
    this.index,
    this.menuList,
    this.popupMenuSelected,
  );

  @override
  _CustomPopupMenuButton createState() => _CustomPopupMenuButton();
}

class _CustomPopupMenuButton extends State<CustomPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<String>> itemList = [];
    for (Map<String, dynamic> item in widget.menuList) {
      itemList.add(
        PopupMenuItem(
          child: Text(item['name']),
          value: item['name'],
        ),
      );
    }

    return PopupMenuButton<String>(onSelected: (String selected) {
      widget.popupMenuSelected(selected, widget.index);
    }, itemBuilder: (BuildContext context) {
      return itemList;
    });
  }
}
