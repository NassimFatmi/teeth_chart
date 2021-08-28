import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToothActions extends StatefulWidget {
  final void Function(Object) updateToothRestoration;
  final void Function(Object) updateToothendodontic;
  final void Function(Object) updateToothImplant;
  final void Function(Object) updateToothOcclusion;
  ToothActions({
    this.updateToothRestoration,
    this.updateToothendodontic,
    this.updateToothImplant,
    this.updateToothOcclusion,
  });

  @override
  _ToothActionsState createState() => _ToothActionsState();
}

class _ToothActionsState extends State<ToothActions> {
  final TextEditingController notes = TextEditingController();

  List restorations = [
    {'color': null, 'value': 'No prosthesis'},
    {'color': Colors.blue, 'value': 'Crown'},
    {'color': Colors.blue, 'value': 'Crown Metal-Ceramic(MC)'},
    {'color': Colors.blue, 'value': 'Crown Ceramic(C)'},
    {'color': Colors.blue, 'value': 'Crown Zirconia(Z)'},
    {'color': Colors.blue, 'value': 'Crown Zirconia-Ceramic(ZC)'},
    {'color': Colors.blue, 'value': 'Crown Metal(M)'},
    {'color': Colors.blue, 'value': 'Crown Metal-Acrylic(MA)'},
    {'color': Colors.blue, 'value': 'Bridge pontic'},
    {'color': Colors.yellow, 'value': 'Defective prosthesis'},
    {'color': Colors.green, 'value': 'Veneer Ceramic(C)'},
    {'color': Colors.green, 'value': 'Veneer Composite(CO)'},
    {'color': Colors.pink, 'value': 'Inlay/Onlay'},
    {'color': Colors.blueGrey, 'value': 'Crown in progress'},
    {'color': Colors.lightGreen, 'value': 'Veneer in progress'},
    {'color': Colors.pink[900], 'value': 'Inlay/Onlay in progress'}
  ];

  List endodontics = [
    {'color': null, 'value': 'Healthy pulp'},
    {'color': Colors.blue, 'value': 'Proper obturation'},
    {'color': Colors.lightGreen, 'value': 'Treatment in progress'},
    {'color': Colors.red, 'value': 'Defective obturation'},
    {'color': Colors.grey, 'value': 'Necrotic pulp'},
    {'color': Colors.pink, 'value': 'Pulpitis'},
  ];

  List implants = [
    {'image': null, 'value': 'No implant'},
    {
      'image': 'assets/teeth/parallel_walled_thread.svg',
      'value': 'parallel_walled_thread'
    },
    {'image': 'assets/teeth/tapered_thread.svg', 'value': 'tapered_thread'},
    {'image': 'assets/teeth/plateau.svg', 'value': 'plateau'},
    {'image': 'assets/teeth/hybrid.svg', 'value': 'hybrid'},
    {'image': 'assets/teeth/mini.svg', 'value': 'mini'},
  ];

  List occlusions = [
    {'value': 'Normal'},
    {'value': 'Over-eruption'},
    {'value': 'Impacted'},
  ];

  String _restorationValue;
  String _endodonticValue;
  String _implantValue;
  String _occlusionValue;

  DropdownMenuItem createDropDownItem(value, color, {image}) {
    return DropdownMenuItem(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 15,
            width: 20,
            color: color,
            child: image != null ? SvgPicture.asset(image) : null,
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  void dispose() {
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: notes,
              decoration: InputDecoration(hintText: 'Enter notes'),
            ),
            SizedBox(height: 10),
            Text('Restorations'),
            DropdownButton(
              hint: Text('Restoration'),
              value: _restorationValue,
              onChanged: (selection) {
                setState(() {
                  _restorationValue = selection;
                });
                this.widget.updateToothRestoration(_restorationValue);
              },
              items: restorations
                  .map((restoration) => createDropDownItem(
                      restoration['value'], restoration['color']))
                  .toList(),
            ),
            SizedBox(height: 10),
            Text('Endodontics'),
            DropdownButton(
              hint: Text('Endodontics'),
              value: _endodonticValue,
              onChanged: (selection) {
                setState(() {
                  _endodonticValue = selection;
                });
                this.widget.updateToothendodontic(_endodonticValue);
              },
              items: endodontics
                  .map((endodontic) => createDropDownItem(
                      endodontic['value'], endodontic['color']))
                  .toList(),
            ),
            SizedBox(height: 10),
            Text('Implant'),
            DropdownButton(
              hint: Text('Implant'),
              value: _implantValue,
              onChanged: (selection) {
                setState(() {
                  _implantValue = selection;
                });
                this.widget.updateToothImplant(_implantValue);
              },
              items: implants
                  .map((implant) => createDropDownItem(implant['value'], null,
                      image: implant['image']))
                  .toList(),
            ),
            SizedBox(height: 10),
            Text('Occlusions'),
            DropdownButton(
              hint: Text('Occlusions'),
              value: _occlusionValue,
              onChanged: (selection) {
                setState(() {
                  _occlusionValue = selection;
                });
                this.widget.updateToothOcclusion(_occlusionValue);
              },
              items: occlusions
                  .map((occlusion) =>
                      createDropDownItem(occlusion['value'], null))
                  .toList(),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }
}
