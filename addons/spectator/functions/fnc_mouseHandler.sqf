#include "\x\tmf\addons\spectator\script_component.hpp"
params["_type","_args"];

switch (_type) do {
    case "MouseButtonDown": {
        _args params ["_displayorcontrol","_button","_x","_y","_shift","_ctrl","_alt"];
        GVAR(mButtons) set [_button,true];
    };

    case "MouseButtonUp": {
        _args params ["_displayorcontrol","_button","_x","_y","_shift","_ctrl","_alt"];
        GVAR(mButtons) set [_button,false];
    };

    case "MouseMoving" : {
        _args params ["_displayorcontrol","_x","_y"];
        GVAR(mPos) = [_x,_y];
    };

    case "MouseZChanged" : {
        _args params ["_displayorcontrol","_value"];
        if((GVAR(modifiers_keys) select 0) && (GVAR(modifiers_keys) select 2)) then
        {
            if(_value > 0) then {GVAR(followcam_fov) = (GVAR(followcam_fov) - 0.05 * _value) max 0.1;};
            if(_value < 0) then {GVAR(followcam_fov) = (GVAR(followcam_fov) + 0.05 * (abs _value)) min 2.0;};
        };
        if(GVAR(mode) == FOLLOWCAM && {_x} count GVAR(modifiers_keys) <= 0) then {
            GVAR(followcam_zoom) = ((GVAR(followcam_zoom) - ((_value)*GVAR(followcam_zoom)/5)) max 0.1) min 650;
        };
        if(GVAR(mode) == FREECAM && {_x} count GVAR(modifiers_keys) <= 1) then
        {
            private _nvalue = GVAR(movement_keys) select 6;
            GVAR(movement_keys) set [6,_nvalue + _value];
        };
    };

    case "ButtonClick": {
        _args params ["_control"];
        _control = ctrlParentControlsGroup _control;
        // Switches to the unit when clicked
        if (GVAR(mode) in [FOLLOWCAM, FREECAM]) then {
            private _target = _control getVariable [QGVAR(attached), objNull];
            if (_target isEqualType grpNull) then {
                _target = leader _target;
            } else {
                _target = effectiveCommander _target;
            };
            [_target] call FUNC(setTarget);
        };
    };
};
