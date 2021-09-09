import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpperBar extends StatefulWidget {
  bool boys;
  bool girls;
  Function setBoys;
  Function setGirls;

  UpperBar({
    @required this.girls,
    @required this.boys,
    @required this.setBoys,
    @required this.setGirls,
  });

  @override
  _UpperBarState createState() => _UpperBarState();
}

class _UpperBarState extends State<UpperBar> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: InkWell(
                onTap: widget.setBoys,
                child: Container(
                  child: Center(
                    child: Text(
                      "BOYS",
                      style: GoogleFonts.lato(
                          color: widget.boys == true && widget.girls == false
                              ? Colors.white
                              : Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      color: widget.boys == true && widget.girls == false
                          ? Colors.lightBlue
                          : null,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            FittedBox(
              child: InkWell(
                onTap: widget.setGirls,
                child: Container(
                  child: Center(
                    child: Text(
                      "GIRLS",
                      style: GoogleFonts.lato(
                          color: widget.boys == false && widget.girls == true
                              ? Colors.white
                              : Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      color: widget.boys == false && widget.girls == true
                          ? Colors.lightBlue
                          : null,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
