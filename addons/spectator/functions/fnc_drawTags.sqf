#include "\x\tmf\addons\spectator\script_component.hpp"

if (GVAR(showMap) || !GVAR(tagsEnabled)) exitWith {
    {_x ctrlShow false} forEach GVAR(tags);
};


// enable hud and grab the user settings variables
cameraEffectEnableHUD true;
private _camPos = getPosVisual GVAR(camera);
private _viewDistance = ((getObjectViewDistance) select 0);
private _ctrlSize = [TAG_W / 2, TAG_ICON_H / 2];

{
    private _attached = _x getVariable [QGVAR(attached), objNull];
    private _tagType = _x getVariable [QGVAR(tagType), -1];

    switch _tagType do {
        case TAGTYPE_GROUP: {
            // grab the group infomation cache
            (_x getVariable [QGVAR(grpCache),[[0,0,0],[1,1,1,1],true]]) params ["_grpPos","_color","_isAI"];

            // check if the average pos is on the screen
            private _screenPos = worldToScreen _grpPos;
            private _distToCam = _grpPos distance _camPos;

            // Render group marker
            if (_screenPos isNotEqualTo [] && _distToCam <= _viewDistance) then {
                _x ctrlShow true;
                TAG_NAME_CTRL(_x) ctrlShow (_distToCam <= 600);
                TAG_DETAIL_CTRL(_x) ctrlShow (_distToCam <= 300);

                _x ctrlSetPosition [_screenPos # 0 - _ctrlSize # 0, _screenPos # 1 - _ctrlSize # 1];
                _x ctrlCommit 0;
            } else {
                _x ctrlShow false;
            };
        };
        case TAGTYPE_UNIT: {
            if (!isNull objectParent _attached) then {
                _x ctrlShow false;
            } else {
                private _pos = ([_attached] call CFUNC(getPosVisual)) vectorAdd [0,0,3.1];
                private _screenPos = worldToScreen _pos;
                private _distToCam = _pos distance _camPos;

                if (_screenPos isNotEqualTo [] && _distToCam <= 500) then {

                    _x ctrlShow true;
                    TAG_NAME_CTRL(_x) ctrlShow (_distToCam <= 300);
                    TAG_DETAIL_CTRL(_x) ctrlShow (_distToCam <= 150);

                    _x ctrlSetPosition [_screenPos # 0 - _ctrlSize # 0, _screenPos # 1 - _ctrlSize # 1];
                    _x ctrlCommit 0;
                }
                else {
                    _x ctrlShow false;
                };
            };
        };
        case TAGTYPE_VEHICLE: {
            private _pos = ([_attached] call CFUNC(getPosVisual)) vectorAdd [0,0,2 + (((boundingBox _attached) select 1) select 2)];

            private _screenPos = worldToScreen _pos;
            private _distToCam = _pos distance _camPos;

            if (_screenPos isNotEqualTo [] && {_distToCam <= 500} ) then {
                _x ctrlShow true;

                TAG_NAME_CTRL(_x) ctrlShow (_distToCam <= 300);
                TAG_DETAIL_CTRL(_x) ctrlShow (_distToCam <= 150);

                _x ctrlSetPosition [_screenPos # 0 - _ctrlSize # 0, _screenPos # 1 - _ctrlSize # 1];
                _x ctrlCommit 0;
            } else {
                _x ctrlShow false;
            };
        };
    };
} forEach GVAR(tags);

////////////////////////////////////////////////////////
// Objectives tags
////////////////////////////////////////////////////////
{
    private _data = _x getVariable [QGVAR(objectiveData),[]];
    if (count _data > 0) then {
        _data params ["_icon","_text","_color"];
        private _fontSize = 0.04;

        private _pos = ([_x] call CFUNC(getPosVisual));
        if (_camPos distance2d _pos > 400) then {_fontSize = 0};

        // draw icon
        drawIcon3D [_icon, _color,_pos, 1, 1, 0,"", 2,_fontSize,"PuristaSemibold" ];
        // draw text
        if (_text != "") then { drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 1, 1, 0,_text, 2,_fontSize,"PuristaSemibold" ]; };
    };
} forEach GVAR(objectives);

/*
////////////////////////////////////////////////////////
// Dead units (skull icon upon death)
////////////////////////////////////////////////////////
{
    _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon","_isplayer"];

    private _time = time - _time;

    private _pos = [_unit] call CFUNC(getPosVisual);
    _pos set [2,(_pos select 2)+1];
    private _name = "";
    if (_isplayer) then {_name = _dName;};
    if (_time <= 10 && {_camPos distance2d _pos <= 500}) then {
        drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", [1,1,1,1 - (0.1 * _time)],_pos, 0.5, 0.5, 0,_name, 2,0.04,"PuristaSemibold" ];
    };
} forEach GVAR(killedUnits);

*/

////////////////////////////////////////////////////////
// Tracers / grenade / rocket tags
////////////////////////////////////////////////////////

if(!GVAR(tracers)) exitWith {};
{
    _x params ["_object","_posArray","_last","_time","_type"];
    private _pos = _posArray select (count _posArray-1);
    if (!isNull _object) then {
        private _pos = [_object] call CFUNC(getPosVisual);
    };
    private _render = (_camPos distance2d _pos <= 400);
    if (_type > 0 && _render) then {
        private _icon = switch (_type) do {
            case 1 : { GRENADE_ICON };
            case 2 : { SMOKE_ICON };
            case 3 : { MISSILE_ICON };
        };
        drawIcon3D[_icon,[1,0,0,0.7],_pos,0.5,0.5,0,"",1,0.02,"PuristaSemibold"];
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
    if(GVAR(bulletTrails) && _type == 0 && _render) then {
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
} forEach GVAR(rounds);
