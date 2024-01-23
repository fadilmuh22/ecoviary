import 'package:ecoviary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class HoursInput extends StatefulWidget {
  final String title;
  final List<TimeOfDay> hours;
  final void Function(List<TimeOfDay>) onChange;

  const HoursInput({
    super.key,
    required this.title,
    required this.hours,
    required this.onChange,
  });

  @override
  State<HoursInput> createState() => _HoursInputState();
}

class _HoursInputState extends State<HoursInput> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
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
        widget.onChange(sortTimeOfDays([...widget.hours, time]));

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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.title,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        height: 30,
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
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 6,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.hours[index].format(context),
                                        ),
                                        const SizedBox(width: 4),
                                        IconButton(
                                          onPressed: () {
                                            widget.onChange(sortTimeOfDays(
                                              [...widget.hours]
                                                ..removeAt(index),
                                            ));
                                          },
                                          icon: const Icon(
                                              FlutterRemix.close_fill),
                                          constraints: const BoxConstraints(),
                                          style: IconButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            iconSize: 16,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'counter: ${widget.hours.length}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _displayTimePicker(context);
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: const Text('Tambah'),
            ),
          ],
        )
      ],
    );
  }
}
