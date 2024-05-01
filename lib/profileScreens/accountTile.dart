import 'package:flutter/material.dart';

class AccountTile extends StatefulWidget {
  final String name;
  final Widget leadingIcon;
  final bool initiallyConnected;

  AccountTile(
      {Key? key,
      required this.name,
      required this.leadingIcon,
      this.initiallyConnected = false})
      : super(key: key);

  @override
  _AccountTileState createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    isConnected = widget.initiallyConnected;
  }

  void _toggleConnection() {
    setState(() {
      isConnected = !isConnected;
      // Here you can add your actual connection logic or API integration
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leadingIcon,
      title: Text(widget.name),
      trailing: ElevatedButton(
        onPressed: _toggleConnection,
        child: Text(isConnected ? 'Connected' : 'Connect'),
        style: ElevatedButton.styleFrom(
          backgroundColor: isConnected
              ? Colors.green
              : null, // Change color based on connection status
        ),
      ),
    );
  }
}
