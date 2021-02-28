#include "script_component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

// Store whether respawn templates are set
GVAR(active) = getMissionConfigValue ["respawn",0] == 1 && (toLower 'ADDON') in ((getMissionConfigValue ["respawnTemplates",[]]) apply {toLower _x});
