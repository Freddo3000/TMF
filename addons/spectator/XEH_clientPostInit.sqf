#include "script_component.hpp"

LOG("Client PostInit started");

["CBA_settingsInitialized", {

    [{
        if (player isKindOf QGVAR(unit)) exitWith {};

        // Check if player is preserved DC unit
        if (player getVariable [QGVAR(preservedDC), false]) exitWith {
            [player, false] remoteExecCall ["hideObjectGlobal", 2];
            [format ["Player JIP to preserved DC unit: %1", profileName],false,"Spectator"] call EFUNC(adminmenu,log);
        };

        // Check if JIP is allowed, if not then kill the JIP player.
        private _isAIunit = player getVariable [QGVAR(isJIPable),false];
        private _isJIPAllowed = switch (GVAR(isJIPAllowed)) do {
            case 0: {false};
            case 1: {true};
            case 2: {[] call EFUNC(safestart,isActive)};
        };

        TRACE_5("Check JIP conditions",GVAR(active), _isJIPAllowed, _isAIunit, CBA_missionTime, didJIP);
        TRACE_1("Check JIP conditions 2",(GVAR(active) && !(_isJIPAllowed || _isAIunit) && CBA_missionTime > 5 && didJIP));

        if (GVAR(active) && !(_isJIPAllowed || _isAIunit) && CBA_missionTime > 5 && didJIP) then {
            LOG("JIP: True");

            [{!isNull player && {!([] call BIS_fnc_isLoading)}},{
                LOG_1("JIP: killing %1", player);
                [player, objNull, true] spawn {
                    private _oldObject = _this # 0;
                    _this call FUNC(init);
                    systemChat "You joined the mission in progress. Entering spectator.";
                    [format ["Player JIP to spectator: %1", profileName],true,"Spectator"] call EFUNC(adminmenu,log);
                    deleteVehicle _oldObject;
                };
            }] call CBA_fnc_waitUntilAndExecute;

        };

    // Add a small delay for things to synchronize
    },[], 0.1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

// Hide ST HUD if spectator is OPEN
if (isClass (configfile >> "CfgPatches" >> "STUI_GroupHUD")) then {
    [{!isNil "STUI_Canvas_ShownHUD"}, {
        STUI_Canvas_ShownHUD_old = STUI_Canvas_ShownHUD;
        STUI_Canvas_ShownHUD = {
            if !(call STUI_Canvas_ShownHUD_old) exitWith {false};
            !(call FUNC(isOpen));
        };
    }, []] call CBA_fnc_waitUntilAndExecute;
};
