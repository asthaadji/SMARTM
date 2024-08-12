import 'package:flutter/material.dart';
// import 'package:smartm/page/sprinkler_stuff/sprinkler_box.dart';
import 'package:smartm/services/sprinkler/sprinkler_model.dart';
import 'package:smartm/services/sprinkler/sprinkler_service.dart';

class SprinklerPage extends StatefulWidget {
  final String authToken;
  final Function(String) onShowSnackBar;
  const SprinklerPage(
      {super.key, required this.authToken, required this.onShowSnackBar});

  @override
  State<SprinklerPage> createState() => _SprinklerPageState();
}

class _SprinklerPageState extends State<SprinklerPage> {
  bool isLoading = true;
  Sprinkler sprinkler = Sprinkler(isActive: false);
  final SprinklerService _sprinklerService = SprinklerService();

  @override
  void initState() {
    super.initState();
    fetchSprinklerStatus();
  }

  Future<void> fetchSprinklerStatus() async {
    try {
      if (!mounted) return;
      final status = await _sprinklerService.getSprinklerStatus();
      setState(() {
        sprinkler = status;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        if (!mounted) return;
        isLoading = false;
        widget.onShowSnackBar('Fetch error: ${e.toString()}');
      });
    }
  }

  Future<void> toggleSprinkler(bool value) async {
    setState(() {
      sprinkler.isActive = value;
    });
    try {
      await _sprinklerService.switchSprinkler(value, widget.authToken);
    } catch (e) {
      widget.onShowSnackBar('Toggle Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kontrol Sprinkle Sprayer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
        const SizedBox(height: 8),
        Container(
            height: 288,
            decoration: BoxDecoration(
                color: Color.fromRGBO(240, 225, 242, 1),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ]),
            padding: const EdgeInsets.all(10),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            title: Text('Sprinkler Status'),
                            trailing: Switch(
                                value: sprinkler.isActive,
                                onChanged: (value) async {
                                  await toggleSprinkler(value);
                                }),
                          )
                        ],
                      )
                    ],
                  ))
      ]),
    );
  }
}
