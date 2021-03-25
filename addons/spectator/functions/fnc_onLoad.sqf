params ["_display"];
#include "\x\tmf\addons\spectator\script_component.hpp"

uiNamespace setVariable [QGVAR(display), _display];
GVAR(unitUpdate) = -1; // Force unit list to update.
with uiNamespace do {
    GVAR(display) = _display;
    GVAR(unitlabel) = _display displayCtrl IDC_TMF_SPECTATOR_UNITLABEL;
    GVAR(unitlist) = _display displayCtrl IDC_TMF_SPECTATOR_UNITLIST;

    GVAR(vision) = _display displayCtrl IDC_TMF_SPECTATOR_VISION;

    GVAR(filter) = _display displayCtrl IDC_TMF_SPECTATOR_FILTER;
    GVAR(side) = _display displayCtrl IDC_TMF_SPECTATOR_BUTTON;
    GVAR(tagsbutton) = _display displayCtrl IDC_TMF_SPECTATOR_TAGS;
    GVAR(view) = _display displayCtrl IDC_TMF_SPECTATOR_VIEW;
    GVAR(mute) = _display displayCtrl IDC_TMF_SPECTATOR_MUTE;
    GVAR(radio) = _display displayCtrl IDC_TMF_SPECTATOR_RADIO;
    GVAR(map) = _display displayCtrl IDC_TMF_SPECTATOR_MAP;
    GVAR(compass) = _display displayCtrl IDC_TMF_SPECTATOR_COMPASS;

    private _labelParent = _display displayCtrl IDC_TMF_SPECTATOR_KILLIST;
    GVAR(labels) = [
        _labelParent controlsGroupCtrl IDC_TMF_SPECTATOR_KILLIST_L1,
        _labelParent controlsGroupCtrl IDC_TMF_SPECTATOR_KILLIST_L2,
        _labelParent controlsGroupCtrl IDC_TMF_SPECTATOR_KILLIST_L3,
        _labelParent controlsGroupCtrl IDC_TMF_SPECTATOR_KILLIST_L4,
        _labelParent controlsGroupCtrl IDC_TMF_SPECTATOR_KILLIST_L5,
        _labelParent controlsGroupCtrl IDC_TMF_SPECTATOR_KILLIST_L6
    ];

    GVAR(map) ctrlShow (missionNamespace getVariable [QGVAR(showMap),false]);
    GVAR(map) mapCenterOnCamera false;

    GVAR(mouseHandlers) = [
        ["MouseButtonDown", {["MouseButtonDown", _this] call FUNC(mouseHandler)}] call CBA_fnc_addDisplayHandler,
        ["MouseButtonUp", {["MouseButtonUp", _this] call FUNC(mouseHandler)}] call CBA_fnc_addDisplayHandler,
        ["MouseZChanged", {["MouseZChanged", _this] call FUNC(mouseHandler)}] call CBA_fnc_addDisplayHandler,
        ["MouseMoving", {["MouseMoving", _this] call FUNC(mouseHandler)}] call CBA_fnc_addDisplayHandler
    ];

};

GVAR(tags) = [];
GVAR(sm) = [configFile >> QGVAR(tagStatemachine)] call CBA_statemachine_fnc_createFromConfig;
if !(missionNamespace getVariable [QGVAR(classHandlersCreated), false]) then {
    ["CAManBase", "init", {
        if !([] call FUNC(isOpen)) exitWith {};

        params ["_unit"];

        private _display = uiNamespace getVariable [QGVAR(display), displayNull];
        [_display, _unit] call FUNC(createTag);

    }] call CBA_fnc_addClassEventHandler;

    // Create tag for vehicle upon getting in, and update crew count and effectiveCommander
    /*["AllVehicles", "getInMan", {
        if !([] call FUNC(isOpen)) exitWith {};
        params ["","","_veh"];

        private _display = uiNamespace getVariable [QGVAR(display), displayNull];
        private _ctrl = [_display, _veh] call FUNC(createTag);

        TAG_DETAIL_CTRL(_ctrl) ctrlSetText format [
            "%1 [%2]",
            name effectiveCommander _veh,
            count crew _veh
        ];
    }] call CBA_fnc_addClassEventHandler;

    // Update crew count or delete tag when dismounting vehicle
    ["AllVehicles", "GetOutMan", {
        if !([] call FUNC(isOpen)) exitWith {};
        params ["_unit","","_veh"];

        if (((crew _veh) - [_unit]) isEqualTo []) exitWith {
            ctrlDelete (_veh getVariable [QGVAR(tagControl), controlNull]);
        };

        private _display = uiNamespace getVariable [QGVAR(display), displayNull];
        private _ctrl = [_display, _veh] call FUNC(createTag);

        TAG_DETAIL_CTRL(_ctrl) ctrlSetText format [
            "%1 [%2]",
            name effectiveCommander _veh,
            count crew _veh
        ];
    }] call CBA_fnc_addClassEventHandler;

    addMissionEventHandler ["EntityKilled",{
        params ["_deadMan","_killer","_instigator"];

        ctrlDelete _deadMan getVariable [QGVAR(tagControl),controlNull];

        if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0};
        if (isNull _instigator) then {_instigator = _killer};

        if(isNull _instigator || _instigator == _deadMan) then {
            _instigator = _deadMan getVariable [QGVAR(lastDamage),objNull];
        };

        private _veh = objectParent _instigator;
        if (isNull _veh) then {

        } else {
            GVAR(killedUnits) pushBack [
                if (isPlayer _deadMan) then [{name _deadMan}, {[configFile >> "CfgWeapons" >> typeOf _deadMan] call BIS_fnc_displayName}],
                time,
                if (isPlayer _instigator) then [{name _instigator}, {[configFile >> "CfgWeapons" >> typeOf _instigator] call BIS_fnc_displayName}],
                if (isNull _veh) then [{
                    [configFile >> "CfgWeapons" >> currentWeapon _instigator] call BIS_fnc_displayName
                },{
                    [configFile >> "CfgWeapons" >> currentWeaponTurret (_veh unitTurret _instigator)] call BIS_fnc_displayName
                }]
            ];
        };

        GVAR(killList_forceUpdate) = true;
    }];
    ["AllVehicles", "fired", {if([] call FUNC(isOpen)) then { _this call FUNC(onFired)}}] call CBA_fnc_addClassEventHandler;
    ["AllVehicles", "hit", {if([] call FUNC(isOpen)) then {(_this select 0) setVariable [QGVAR(lastDamage),(_this select 3)]}}] call CBA_fnc_addClassEventHandler;
    */

    GVAR(classHandlersCreated) = true;
};

{
    [_display, _x] call FUNC(createTag);
    [_display, group _x] call FUNC(createTag);

    private _veh = objectParent _x;
    if (!isNull _veh) then {
        [_display, _x] call FUNC(createTag);
    };
} forEach allUnits;

if(!GVAR(canSpectateAllSides)) then {
    GVAR(sides) = [GVAR(EntrySide)];
    GVAR(sides_button_mode) = [[GVAR(EntrySide)], []];
    GVAR(sides_button_strings) = ["SHOWING YOUR SIDE", "NONE"];
};

if (!isNil QGVAR(zeusPos) && { GVAR(freeCameraEnabled) }) then {
    GVAR(mode) = FREECAM;
    [] call FUNC(setTarget);

    private _pitch = GVAR(zeusPitchBank) select 0;
    GVAR(followcam_angle) = [GVAR(zeusDir),_pitch];
    GVAR(camera) setPos GVAR(zeusPos);
    GVAR(camera) setDir GVAR(zeusDir);
    [GVAR(camera),_pitch,0] call BIS_fnc_setPitchBank;
    GVAR(camera) camSetFov GVAR(followcam_fov);
    GVAR(camera) camCommit 0;
    GVAR(zeusPos) = nil;
} else {
    if (missionNamespace getVariable [QGVAR(mode),-1] isEqualTo -1) then {
        private _allowedModes = [GVAR(followCameraEnabled),GVAR(freeCameraEnabled),GVAR(firstPersonCameraEnabled)];
        {
            if(_x) exitWith {
                GVAR(mode) = _forEachIndex;
                [] call FUNC(setTarget);
            };
        } forEach _allowedModes;
    } else {
        [] call FUNC(setTarget);
    };
};

// if ACRE2 is enabled, enable the mute button
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    [true] call acre_api_fnc_setSpectator;
    private _data = ["ACRE2","HeadSet"] call CBA_fnc_getKeybind;
    GVAR(mute_key) = (_data select 5) select 0;
    GVAR(mute_modifers) = (_data select 5) select 1;

    // Add all languages
    if (!isNil QEGVAR(acre2,languagesTable)) then {
        private _languages = EGVAR(acre2,languagesTable) apply {_x select 0};
        _languages call acre_api_fnc_babelSetSpokenLanguages;
    };
}
else { // else remove it
    with uiNamespace do {
        GVAR(mute) ctrlShow false; // hide mute button
        GVAR(radio) ctrlShow false;
    };
};

[QGVAR(displayOnLoad), [_display]] call CBA_fnc_localEvent;
