import 'package:dentist/tooth_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class Tooth extends StatefulWidget {
  int toothIndex;
  String type;

  Tooth({
    this.toothIndex,
    this.type,
  });

  @override
  _ToothState createState() => _ToothState();
}

class _ToothState extends State<Tooth> {
  bool isRemoved = false;
  bool isNeedsExtraction = false;
  bool isImplanted = false;
  bool isOcclusion = false;

  // 80 for adult tooth and 60 for underAge
  double toothSize = 80;
  var upColor;
  var downColor;
  String restoration = "No prosthesis";
  String endodontic = "Healthy pulp";
  String implant = "No implant";
  String occlusion = "Normal";

  remove() {
    setState(() {
      isNeedsExtraction = false;
      isRemoved = !isRemoved;
    });
  }

  needsExtraction() {
    setState(() {
      isRemoved = false;
      isNeedsExtraction = !isNeedsExtraction;
    });
  }

  toggleTheTeeth() {
    setState(() {
      this.widget.toothIndex = this.widget.toothIndex < 50
          ? (this.widget.toothIndex % 10 >= 6
              ? this.widget.toothIndex
              : (this.widget.toothIndex + 40))
          : (this.widget.toothIndex - 40);
    });
    toothSize = this.widget.toothIndex > 50 ? 60 : 80;
  }

  toothActions() {
    showDialog(
        context: context,
        builder: (context) {
          return ToothActions();
        });
  }

  updateToothRestoration(restoration) {
    String theRestoration = restoration.toLowerCase();

    if (theRestoration == "no prosthesis") {
      setState(() {
        upColor = null;
      });
    }

    if (theRestoration.contains('crown') || theRestoration == "bridge pontic") {
      setState(() {
        upColor =
            theRestoration.contains('progress') ? Colors.blueGrey : Colors.blue;
      });
    }
    if (theRestoration == "defective prosthesis") {
      setState(() {
        upColor = Colors.yellow;
      });
    }
    if (theRestoration.contains('veneer')) {
      setState(() {
        upColor = theRestoration.contains('progress')
            ? Colors.lightGreen
            : Colors.green;
      });
    }
    if (theRestoration == "inlay/onlay") {
      setState(() {
        upColor = theRestoration.contains('progress')
            ? Colors.pink[900]
            : Colors.pink;
      });
    }
    this.restoration = restoration;
  }

  updateToothendodontic(endodontic) {
    String theEndodontic = endodontic.toLowerCase();
    if (theEndodontic == "proper obturation") {
      setState(() {
        downColor = Colors.blue;
      });
    }
    if (theEndodontic.contains('progress')) {
      setState(() {
        downColor = Colors.green;
      });
    }
    if (theEndodontic == "defective obturation") {
      setState(() {
        downColor = Colors.red;
      });
    }
    if (theEndodontic == "necrotic pulp") {
      setState(() {
        downColor = Colors.grey;
      });
    }
    if (theEndodontic == "pulpitis") {
      setState(() {
        downColor = Colors.pink;
      });
    }

    this.endodontic = endodontic;
  }

  updateToothImplant(implant) {
    if (implant.toLowerCase() == "no implant") {
      setState(() {
        isImplanted = false;
      });
    } else {
      setState(() {
        isImplanted = true;
      });
    }
    this.implant = implant;
  }

  updateOcclusion(occlusion) {
    this.occlusion = occlusion;

    if (occlusion.toLowerCase() == "normal") {
      setState(() {
        isOcclusion = false;
      });
    } else {
      setState(() {
        isOcclusion = true;
      });
    }
  }

  _renderTooth() {
    bool reversed = false;
    if (this.widget.toothIndex < 30 ||
        (this.widget.toothIndex > 50 && this.widget.toothIndex < 70)) {
      reversed = true;
    }
    Widget up = SvgPicture.asset(
      'assets/teeth/${widget.toothIndex}_up.svg',
      height: toothSize - 20,
      color: upColor,
    );
    Widget down = Transform.rotate(
      angle: isImplanted && reversed ? math.pi : 0,
      child: SvgPicture.asset(
        isImplanted
            ? 'assets/teeth/$implant.svg'
            : 'assets/teeth/${widget.toothIndex}_down.svg',
        height: toothSize,
        color: downColor,
      ),
    );

    Widget colorsCircle = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
    );

    var tooth = isRemoved
        ? Icon(
            Icons.close,
            size: 35,
            color: Colors.red,
          )
        : isNeedsExtraction
            ? Icon(
                Icons.priority_high,
                size: 35,
                color: Colors.red,
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: reversed ? [down, up] : [up, down],
                  ),
                  isOcclusion
                      ? Positioned(
                          top: 25,
                          child: Icon(
                            this.occlusion.toLowerCase() == "impacted"
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: Colors.red,
                            size: 35,
                          ))
                      : const SizedBox.shrink(),
                ],
              );

    return Container(
        height: 250,
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: reversed ? [tooth, colorsCircle] : [colorsCircle, tooth],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Restoration: ${this.restoration}\nEndodontic: ${this.endodontic}\nImplant: ${this.implant}\nOcclusion: ${this.occlusion}'),
        ));
      },
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.close),
                    title: Text('Remove'),
                    onTap: () {
                      remove();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.import_export),
                    title: Text('N/A'),
                    onTap: () {
                      toggleTheTeeth();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => ToothActions(
                                updateToothRestoration: updateToothRestoration,
                                updateToothendodontic: updateToothendodontic,
                                updateToothImplant: updateToothImplant,
                                updateToothOcclusion: updateOcclusion,
                              ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.priority_high),
                    title: Text('Needs Extraction'),
                    onTap: () {
                      needsExtraction();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      },
      child: _renderTooth(),
    );
  }
}
