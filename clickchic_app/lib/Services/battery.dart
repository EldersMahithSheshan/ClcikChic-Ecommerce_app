import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryStatusWidget extends StatefulWidget {
  @override
  _BatteryStatusWidgetState createState() => _BatteryStatusWidgetState();
}

class _BatteryStatusWidgetState extends State<BatteryStatusWidget> {
  final Battery _battery = Battery();
  int _batteryLevel = 0;
  BatteryState _batteryState = BatteryState.unknown;

  @override
  void initState() {
    super.initState();
    _initBatteryStatus();
  }

  Future<void> _initBatteryStatus() async {
    try {
      // Get the initial battery level
      final int batteryLevel = await _battery.batteryLevel;
      print("Battery level fetched: $batteryLevel%");

      if (mounted) {
        setState(() {
          _batteryLevel = batteryLevel;
        });
      }
    } catch (e) {
      print("Error fetching battery level: $e");
    }

    // Listen for changes in battery state
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      print("Battery state changed: $state");
      if (mounted) {
        setState(() {
          _batteryState = state;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      children: [
        Text(
          "$_batteryLevel%", // Shows battery level
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0), // Space between texts
        Text(
          _batteryState == BatteryState.charging ? 'Charging' : 'Not Charging',
          style: TextStyle(
            fontSize: 12,
            color: _batteryState == BatteryState.charging
                ? Colors.green
                : Colors.red,
          ),
        ),
      ],
    );
  }
}
