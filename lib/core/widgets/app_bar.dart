import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.onChanged});

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  final Function onChanged;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching ? _buildSearchTextField() : Text('Cloud Walk'),
      backgroundColor: Colors.grey,
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            if(_isSearching){
              widget.onChanged('');
            }
            setState(() {
              _isSearching = !_isSearching;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _isSearching ? MediaQuery.of(context).size.width - 100 : 0,
        child: _isSearching
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                ),
                onChanged: (value) {
                  widget.onChanged(value);
                },
              )
            : null,
      ),
    );
  }
}