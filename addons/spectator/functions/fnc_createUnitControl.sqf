#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_unit"];
disableSerialization;
private _color = (side group _unit) call CFUNC(sideToColor);

private _control = (uiNamespace getVariable [QGVAR(display),displayNull]) ctrlCreate [QGVAR(Tag), -1];

_control ctrlShow false;

TAG_ICON_CTRL(_control) ctrlSetText "\A3\ui_f\data\map\markers\military\triangle_CA.paa";
TAG_ICON_CTRL(_control) ctrlSetTextColor _color;
TAG_NAME_CTRL(_control) ctrlSetText name _unit;
TAG_DETAIL_CTRL(_control) ctrlSetText "";

_unit setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_unit];

GVAR(controls) pushBack _control;

_control
