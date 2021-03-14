#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;
params ["_display", "_exitCode"];

GVAR(camera) cameraEffect ["TERMINATE","BACK"];

["MouseButtonDown", GVAR(mouseHandlers) # 0] call CBA_fnc_removeDisplayHandler;
["MouseButtonUp", GVAR(mouseHandlers) # 1] call CBA_fnc_removeDisplayHandler;
["MouseZChanged", GVAR(mouseHandlers) # 2] call CBA_fnc_removeDisplayHandler;
["MouseMoving", GVAR(mouseHandlers) # 3] call CBA_fnc_removeDisplayHandler;

[QGVAR(displayOnUnload), _this] call CBA_fnc_localEvent;
