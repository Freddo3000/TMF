#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_grp"];
disableSerialization;

private _control = (uiNamespace getVariable [QGVAR(display),displayNull]) ctrlCreate [QGVAR(Tag), -1];
_control ctrlShow false;

private _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);
if (count _twGrpMkr == 3) then {
    _twGrpMkr params ["_grpTexture","_gname"];

    TAG_ICON_CTRL(_control) ctrlSetText _grpTexture;
    TAG_ICON_CTRL(_control) ctrlSetTextColor [1,1,1,1];
    TAG_NAME_CTRL(_control) ctrlSetText _gname;
} else {
    private _grpCache = _x getVariable [QGVAR(grpCache),[[], [1,1,1,1], true]];
    private _grpPos = _grpCache # 0;
    if (count _grpPos <= 0) then {
        _grpCache = ([_x] call FUNC(updateGroupCache));
    };
    TAG_ICON_CTRL(_control) ctrlSetText "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
    TAG_ICON_CTRL(_control) ctrlSetTextColor (_grpCache # 1);
    TAG_NAME_CTRL(_control) ctrlSetText groupId _grp;
};
[_control,"",[],true] call FUNC(controlSetText);
_grp setVariable [QGVAR(tagControl), [_control]];
_control setVariable [QGVAR(attached),_grp];
GVAR(controls) pushBack _control;
