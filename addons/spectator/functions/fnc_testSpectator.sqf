#include "\x\tmf\addons\spectator\script_component.hpp"
// TMF Spectator configured.
private _output = [];

if (getMissionConfigValue ["respawn",0] == 1 && (toLower 'ADDON') in ((getMissionConfigValue ["respawnTemplates",[]]) apply {toLower _x})) then {
    _output pushBack [0,"TMF Spectator is not setup correctly. See wiki for instructions."];
};



_output
