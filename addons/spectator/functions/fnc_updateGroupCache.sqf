#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_grp"];

private _avgpos = [0,0,0];

private _vehicles = ((units _grp) select {!isNull (objectParent _x)}) apply {objectParent _x};

_vehicles = _vehicles arrayIntersect _vehicles;

private _color = (side _grp) call CFUNC(sideToColor);

private _hasPlayers = (units _grp findIf { isPlayer _x || _x in playableUnits }) >= 0;

if(_hasPlayers || {GVAR(showGroupMarkers) == 1}) then {
    if(count (units _grp) > 1 && ((count _vehicles) != 1) ) then {
        private _cluster = ([units _grp] call FUNC(getGroupClusters));
        if (count _cluster > 0) then {
            {
                _pos = [_x] call CFUNC(getPosVisual);
                _avgpos = _avgpos vectorAdd _pos;
            } forEach _cluster;
            private _c = count _cluster;
            _avgpos = _avgpos vectorMultiply (1/_c);
            _avgpos set [2,(_avgpos select 2)+10];
        };
    } else {
        _avgpos = [leader _grp] call CFUNC(getPosVisual);
        _avgpos set [2,(_avgpos select 2)+10];
    };
};

_grp setVariable [QGVAR(grpCache),[_avgpos,_color, !_hasPlayers]];

_cache
