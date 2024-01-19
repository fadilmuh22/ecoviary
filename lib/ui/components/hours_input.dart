import 'package:flutter/material.dart';

class HoursInput extends StatefulWidget {
  final List<TimeOfDay> hours;
  final Function(List<TimeOfDay>) onChange;

  const HoursInput({
    super.key,
    required this.hours,
    required this.onChange,
  });

  @override
  State<HoursInput> createState() => _HoursInputState();
}

class _HoursInputState extends State<HoursInput> {
  ScrollController? _scrollController;

  _scrollListener() {
    print('scrolling');
    if (_scrollController == null) return;

    if (_scrollController!.offset >=
            _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      print('react the bottom');
    }
    if (_scrollController!.offset <=
            _scrollController!.position.minScrollExtent &&
        !_scrollController!.position.outOfRange) {
      print('react the top');
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  Future<void> _displayTimePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = TimeOfDay.now();
    var time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (time != null) {
      setState(() {
        widget.onChange([...widget.hours, time]);
        Future.delayed(const Duration(microseconds: 100), () {
          _scrollController?.animateTo(
            _scrollController!.position.maxScrollExtent + 100,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 150),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 300,
      child: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 5.0,
            children: List<Widget>.generate(
              widget.hours.length,
              (int index) {
                return InputChip(
                  visualDensity: VisualDensity.comfortable,
                  label: Text(widget.hours[index].format(context)),
                  onDeleted: () {
                    setState(() {
                      widget.hours.removeAt(index);
                    });
                  },
                );
              },
            ).toList(),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              SizedBox(width: widget.hours.isEmpty ? 100 : 0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _displayTimePicker(context);
                  });
                },
                child: const Text('Tambah'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
