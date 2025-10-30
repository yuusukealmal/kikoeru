// flutter
import "dart:convert";
import "package:flutter/material.dart";

// frb
import "package:kikoeru/src/rust/api/requests/interface.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

class StarRating extends StatefulWidget {
  const StarRating({super.key, required this.work});

  final WorkInfo work;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        bool isHovered = hoveredIndex == index;
        Color starColor =
            widget.work.userRating == null ? Colors.amber : Color(0xFF2196F3);
        num starRating = widget.work.userRating ?? widget.work.rateAverage2dp;

        IconData iconData;
        if (index < starRating) {
          if (starRating - index >= 1) {
            iconData = Icons.star;
          } else {
            iconData = Icons.star_half;
          }
        } else {
          iconData = Icons.star_border;
        }

        return MouseRegion(
          onEnter: (_) {
            hoveredIndex = index;
          },
          onExit: (_) {
            setState(() {
              hoveredIndex = null;
            });
          },
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                hoveredIndex = index;
              });
            },
            onTapUp: (_) {
              setState(() {
                hoveredIndex = null;
              });
            },
            onTapCancel: () {
              setState(() {
                hoveredIndex = null;
              });
            },
            onTap: () async {
              String response = await updateRate(
                id: widget.work.id.toString(),
                rate: index + 1,
              );

              if (jsonDecode(response)["message"] == "更新成功") {
                setState(() {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("更新成功")));
                  widget.work.userRating = index + 1;
                });
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              child: Icon(
                iconData,
                size: isHovered ? 28 : 22,
                color: starColor.withValues(
                  alpha:
                      hoveredIndex != null && index > hoveredIndex! ? 0.5 : 1.0,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
