import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/text.dart';

enum TimerMode { countUp, countDown }

// ignore: camel_case_types
class timeWatchWidget extends StatefulWidget {
  final TimerMode mode;
  final DateTime? endTime;
  final String? label;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final bool isAction;
  final Function()? onFinish;

  const timeWatchWidget({
    super.key,
    this.mode = TimerMode.countUp,
    this.endTime,
    this.label,
    this.textStyle,
    this.labelStyle,
    this.isAction = false,
    this.onFinish,
  });

  @override
  // ignore: library_private_types_in_public_api
  _timeWatchWidgetState createState() => _timeWatchWidgetState();
}

// ignore: camel_case_types
class _timeWatchWidgetState extends State<timeWatchWidget> {
  Duration _time = Duration.zero;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();

    if (widget.mode == TimerMode.countDown) {
      if (widget.endTime == null) {
        throw ArgumentError("endTime harus diisi jika mode adalah countDown");
      }

      final remaining = widget.endTime!.difference(DateTime.now());
      _time = remaining.isNegative ? Duration.zero : remaining;

      if (widget.isAction == false) {
        _startTimer();
      }
    }
  }

  void _startTimer() {
    if (_isRunning) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.mode == TimerMode.countUp) {
          _time += Duration(seconds: 1);
        } else {
          final remaining = widget.endTime!.difference(DateTime.now());
          _time = remaining.isNegative ? Duration.zero : remaining;

          if (_time == Duration.zero) {
            _timer?.cancel();
            _isRunning = false;

            if (widget.onFinish != null) {
              widget.onFinish!();
            }
          }
        }
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      if (widget.mode == TimerMode.countUp) {
        _time = Duration.zero;
      } else {
        final remaining = widget.endTime!.difference(DateTime.now());
        _time = remaining.isNegative ? Duration.zero : remaining;
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(duration.inHours);
    final m = twoDigits(duration.inMinutes.remainder(60));
    final s = twoDigits(duration.inSeconds.remainder(60));
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.label == null
            ? Container()
            : Text(
                widget.label ?? '',
                style: widget.labelStyle ?? bold_12_1,
              ),
        widget.label == null
            ? Container()
            : const SizedBox(
                height: 10,
              ),
        Text(
          _formatDuration(_time),
          style: widget.textStyle ?? bold_30_4,
        ),
        widget.isAction == false ? Container() : const SizedBox(height: 16),
        widget.isAction == false
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    child: Text(_isRunning ? 'Pause' : 'Start'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: const Text('Reset'),
                  ),
                ],
              ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
