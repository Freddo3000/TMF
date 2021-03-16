#include "\x\tmf\addons\spectator\script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: TMF_spectator_fnc_createTag

Description:
    Creates a spectator tag control for entity

Parameters:
    _display - Display to create control on [Display]
    _thing - Entity to create tag for [Object or Group]

Returns:
    Created control, or already existing control

Examples:
    (begin example)
        _ctrl = [_display, group player] call TMF_spectator_fnc_createTag
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */

params ["_display", ["_thing", objNull]];

if (isNull _thing) exitWith {controlNull};

// Check if control already exists
private _ctrl = (_thing getVariable QGVAR(tagControl)) param [0, controlNull];
if (!isNull _ctrl) exitWith {_ctrl};

_ctrl = _display ctrlCreate [QGVAR(Tag), -1];
_ctrl ctrlShow false;

switch true do {
	case IS_GROUP(_thing): {
        // Create a group marker
		private _twGrpMkr = [_thing] call EFUNC(orbat,getGroupMarkerData);

		if (count _twGrpMkr == 3) then {
            // Group has a TMF Orbat marker
			_twGrpMkr params ["_grpTexture","_gname"];

			TAG_ICON_CTRL(_ctrl) ctrlSetText _grpTexture;
			TAG_ICON_CTRL(_ctrl) ctrlSetTextColor [1,1,1,1];
			TAG_NAME_CTRL(_ctrl) ctrlSetText _gname;
		} else {
            // Group has no marker, use placeholder.
			private _grpCache = _thing getVariable [QGVAR(grpCache),[[], [1,1,1,1], true]];
			private _grpPos = _grpCache # 0;
			if (count _grpPos <= 0) then {
				_grpCache = ([_thing] call FUNC(updateGroupCache));
			};
			TAG_ICON_CTRL(_ctrl) ctrlSetText GROUP_ICON;
			TAG_ICON_CTRL(_ctrl) ctrlSetTextColor (_grpCache # 1);
			TAG_NAME_CTRL(_ctrl) ctrlSetText groupId _grp;
		};
        TAG_DETAIL_CTRL(_ctrl) ctrlSetText "";
        _ctrl setVariable [QGVAR(tagType), TAGTYPE_GROUP];
	};
	case (_thing isKindOf "CAManBase"): {

        private _markerEntry = _thing getVariable ["TMF_SpecialistMarker",[]];
        if IS_STRING(_markerEntry) then { _markerEntry = call compile _markerEntry; };

        if (count _markerEntry >= 2 && {_markerEntry isNotEqualTo ["", ""]}) then {
            // Unit has a specialist marker
            _markerEntry params [["_textureC", ""], ["_markerNameC", ""]];

            TAG_ICON_CTRL(_ctrl) ctrlSetText _textureC;
            TAG_ICON_CTRL(_ctrl) ctrlSetTextColor [1,1,1,1];
            TAG_NAME_CTRL(_ctrl) ctrlSetText name _thing;
            TAG_DETAIL_CTRL(_ctrl) ctrlSetText _markerNameC;
        } else {
            TAG_ICON_CTRL(_ctrl) ctrlSetText UNIT_ICON;
            TAG_ICON_CTRL(_ctrl) ctrlSetTextColor ((side _thing) call CFUNC(sideToColor));
            TAG_NAME_CTRL(_ctrl) ctrlSetText name _thing;
            TAG_DETAIL_CTRL(_ctrl) ctrlSetText "";
        };

        _ctrl setVariable [QGVAR(tagType), TAGTYPE_UNIT];
	};
	default {
        // Assume generic vehicle
        private _markerEntry = _thing getVariable [QGVARMAIN(VehicleMarker),[]];
        if IS_STRING(_markerEntry) then { _markerEntry = call compile _markerEntry; };

        if (count _markerEntry >= 2 && {_markerEntry isNotEqualTo ["", ""]}) then {
            _markerEntry params ["_textureC", "_markerNameC"];

            TAG_ICON_CTRL(_ctrl) ctrlSetText _textureC;
            TAG_ICON_CTRL(_ctrl) ctrlSetTextColor [1,1,1,1];
        } else {
            TAG_ICON_CTRL(_ctrl) ctrlSetText VEHICLE_ICON;
            TAG_ICON_CTRL(_ctrl) ctrlSetTextColor ((side _thing) call CFUNC(sideToColor));
        };

        TAG_NAME_CTRL(_ctrl) ctrlSetText (_thing getVariable [
            QEGVAR(orbat,vehiclecallsign),
            getText (configFile >> "CfgVehicles" >> typeof _thing >> "displayName")
        ]);
        TAG_DETAIL_CTRL(_ctrl) ctrlSetText "";

        _ctrl setVariable [QGVAR(tagType), TAGTYPE_VEHICLE];
	};
};

_thing setVariable [QGVAR(tagControl), [_ctrl]];
_ctrl setVariable [QGVAR(attached),_thing];
GVAR(tags) pushBack _ctrl;

_ctrl
