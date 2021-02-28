#include "\x\tmf\addons\spectator\script_component.hpp"

if (!isNil "ace_common_fnc_addCanInteractWithCondition") then {
    [QGVAR(spectatingCondition), {isNull (findDisplay IDC_SPECTATOR_TMF_SPECTATOR_DIALOG)}] call ace_common_fnc_addCanInteractWithCondition;
};

if (isServer) then {
    GVAR(radioChannel) = radioChannelCreate [[0.96, 0.34, 0.13, 0.8],"Spectator Chat","[SPECTATOR] %UNIT_NAME",[]];
    publicVariable QGVAR(radioChannel);

    createCenter sideLogic;
    GVAR(group) = createGroup sideLogic;

    if (isNull GVAR(group)) then {
        createCenter civilian;
        GVAR(group) = createGroup civilian;
    };

    publicVariable QGVAR(group);

    [{
        GVAR(dcEH) = addMissionEventHandler ["HandleDisconnect",{
            params ["_unit"];
            private ["_rtrn"];

            // Clean up disconnected spectator units.
            if (_unit isKindOf QGVAR(unit)) then {
                deleteVehicle _unit;
                _rtrn = false;
            } else {

                if GVAR(active) then {
                    // Preserve hidden DC units if AI slots are disabled
                    if (GVAR(preserveDCUnits) && ((getMissionConfigValue ["DisabledAI", false]) in [1,true])) then {
                        hideObjectGlobal _unit;
                        moveOut _unit;
                        _unit setPos ((getPos _unit) select [0, 2]); // Move to ground
                        _unit setVelocity [0,0,0];
                        _unit setVariable [QGVAR(preservedDC), true, true];
                        [format ["Preserved DC unit: %1", name _unit], false, "Spectator"] call EFUNC(adminmenu,log);
                        _rtrn = true;
                    } else {

                        [format ["Unit disconnected while not spectator: %1", name _unit], true, "Spectator"] call EFUNC(adminmenu,log);
                        _rtrn = false;
                    };
                };
            };

            // exitWith does not work with this EH
            _rtrn
        }];
    // Add EH last to ensure effect
    }] call CBA_fnc_execNextFrame;

    [{
        {
            // Mark player as JIPable on mission start
            // This is kept if the player is DC'd and controlled by AI
            _x setVariable [QGVAR(isJIPable),true,true];
        } forEach playableUnits;
    },[],0.01] call CBA_fnc_waitAndExecute;

};
