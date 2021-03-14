#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_veh"];
disableSerialization;
private _color = [1,1,1,1];
private _control = (uiNamespace getVariable [QGVAR(display),displayNull]) ctrlCreate [QGVAR(Tag), -1];

_control ctrlShow false;

TAG_ICON_CTRL(_control) ctrlSetText VEHICLE_ICON;
TAG_ICON_CTRL(_control) ctrlSetTextColor _color;
TAG_NAME_CTRL(_control) ctrlSetText name _unit;
TAG_DETAIL_CTRL(_control) ctrlSetText "";

[_control,VEHICLE_ICON,_color] call FUNC(controlSetPicture);
[_control,getText (configFile >> "CfgVehicles" >> typeof _veh >> "displayName")] call FUNC(controlSetText);

_veh setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_veh];
GVAR(controls) pushBack _control;
