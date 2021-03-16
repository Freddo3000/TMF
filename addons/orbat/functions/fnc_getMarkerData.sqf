#include "\x\tmf\addons\orbat\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_orbat_fnc_getMarkerData

Description:
    Gets TMF orbat marker data from group, unit, or object.

Parameters:
    _thing - Thing to get marker data from [Group or Object]

Returns:
    Array - Marker data for _thing [Default []]

Author:
    Freddo
---------------------------------------------------------------------------- */
params ["_thing"];

private _rtrn = _thing getVariable [QGVAR(cachedData), []];

if (_rtrn isNotEqualTo []) exitWith {_rtrn};


switch true do {
    case IS_GROUP(_thing): {
        // Group marker
        _rtrn = _thing getVariable [QGVARMAIN(groupMarker),[]];
        if IS_STRING(_rtrn) then {_rtrn = call compile _rtrn};
    };
    case (_thing isKindOf "CAManBase"): {
        // Specialist marker
        _rtrn = _thing getVariable [QGVARMAIN(SpecialistMarker),[]];
        if IS_STRING(_rtrn) then { _rtrn = call compile _rtrn; };
    };
    case IS_OBJECT(_thing): {
        // Vehicle marker
        private _rtrn = _thing getVariable [QGVARMAIN(VehicleMarker),[]];
        if IS_STRING(_rtrn) then { _rtrn = call compile _rtrn; };
    };
};

_thing setVariable [QGVAR(cachedData), _rtrn];

_rtrn
