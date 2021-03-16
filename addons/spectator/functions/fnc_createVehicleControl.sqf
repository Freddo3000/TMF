#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_display", "_veh"];
disableSerialization;
private _color = [1,1,1,1];
private _ctrl = _display ctrlCreate [QGVAR(Tag), -1];

_ctrl ctrlShow false;

TAG_ICON_CTRL(_ctrl) ctrlSetText VEHICLE_ICON;
TAG_ICON_CTRL(_ctrl) ctrlSetTextColor _color;
TAG_NAME_CTRL(_ctrl) ctrlSetText getText (configFile >> "CfgVehicles" >> typeof _veh >> "displayName");
TAG_DETAIL_CTRL(_ctrl) ctrlSetText "";

_veh setVariable [QGVAR(tagControl), [_ctrl]];
_ctrl setVariable [QGVAR(attached),_veh];

_ctrl

