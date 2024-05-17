// features/home/presentation/widgets/tab_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/theme/app_colors.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({
    super.key,
    required this.tabs,
    required this.controller,
  });
  final List<String> tabs;
  final TabController controller;

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.tabs
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      widget.controller.animateTo(widget.tabs.indexOf(e));
                    },
                    child: AnimatedContainer(
                      width: context.propWidth(80),
                      height: context.propHeight(30),
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: widget.controller.index == widget.tabs.indexOf(e)
                            ? AppColors.secondaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      curve: Curves.easeIn,
                      child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              widget.controller.index == widget.tabs.indexOf(e)
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: context.propHeight(10),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
