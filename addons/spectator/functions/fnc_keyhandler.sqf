#include "\x\tmf\addons\spectator\script_component.hpp"
#include "\a3\3den\UI\dikCodes.inc"
#define KEYDOWN 0

params ["_type","_args"];
_args params ["_control","_key","_shift","_ctrl","_alt"];

_done = true;
switch true do {
  case (_key == DIK_ESCAPE && _type == KEYDOWN) :
  {
    [QGVAR(blackout),false] call BIS_fnc_blackOut;
    with uiNamespace do {
      closeDialog 0;
      _display = (findDisplay 46) createDisplay (["RscDisplayInterrupt","RscDisplayMPInterrupt"] select isMultiplayer);
      _display displayAddEventHandler  ["Unload", {
          with missionNamespace do {
            [player,player,true] call FUNC(init);
            [QGVAR(blackout)] call BIS_fnc_blackIn;
          };
      }];
    };
    _done = true;
  };
  case (_key == DIK_A) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [1,true];
      }
      else
      {
          GVAR(movement_keys) set [1,false];
      };
  };
  case (_key == DIK_D) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [3,true];

      }
      else
      {
          GVAR(movement_keys) set [3,false];

      };
  };
  case (_key == DIK_W) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [0,true];
      }
      else
      {
          GVAR(movement_keys) set [0,false];
          //_done = true;
      };
  };
  case (_key == DIK_S) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [2,true];
      } else {
          GVAR(movement_keys) set [2,false];
          //_done = true;
      };
  };
  case (_key == DIK_Q) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [4,true];
      } else {
          GVAR(movement_keys) set [4,false];
      };
  };
  case (_key in (actionKeys "NightVision") && _type == KEYDOWN && !GVAR(showmap)) : {
        ['vision',[uinamespace getVariable [QGVAR(vision),controlNull]]] call FUNC(menuhandler);
  };
  case (_key == DIK_Z) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [5,true];
      } else {
          GVAR(movement_keys) set [5,false];
      };
  };
  case (_key in (actionKeys "ReloadMagazine")) : {
      if(_type == KEYDOWN) then {
          GVAR(showlines) = true;
      } else {
          GVAR(showlines) = false;
      };
  };
  case (_key in [DIK_RSHIFT,DIK_LSHIFT]) : {
      if(_type == KEYDOWN) then {
          GVAR(modifiers_keys) set [1,true];
      } else {
          GVAR(modifiers_keys) set [1,false];
      };
  };
  case (_key in [DIK_LMENU]) : { // Alt
      if(_type == KEYDOWN) then {
          GVAR(modifiers_keys) set [2,true];
      } else {
          GVAR(modifiers_keys) set [2,false];
      };
  };
  case (_key in [DIK_LCONTROL]) : { // Ctrl
      if(_type == KEYDOWN) then {
          GVAR(modifiers_keys) set [0,true];
      } else {
          GVAR(modifiers_keys) set [0,false];
      };
  };
  case (_key in actionKeys "ShowMap") : {
      if(_type == KEYDOWN) then {
          GVAR(showMap) = !GVAR(showMap);
          with uiNamespace do {
              _mapshow = (missionNamespace getVariable [QGVAR(showMap),false]);
              GVAR(map) ctrlShow _mapshow;
              GVAR(map) ctrlMapAnimAdd [0,0.05,missionNamespace getVariable [QGVAR(target),GVAR(camera)]];
              ctrlMapAnimCommit GVAR(map);
          };
      };
  };
    case (_key == GVAR(mute_key)) : {
        if(_type == KEYDOWN && (GVAR(modifiers_keys)) isEqualTo (GVAR(mute_modifers))) then {
            [] call acre_sys_core_fnc_toggleHeadset;
        };
    };
    case (_key == DIK_T && _type == KEYDOWN): {
        GVAR(tracers) = !GVAR(tracers);
        _message = "Tracers have been toggled off";
        if(GVAR(tracers)) then {_message = "Tracers have been toggled on"};
        systemChat _message;
    };
    case (_key == DIK_K && _type == KEYDOWN): {
        GVAR(bulletTrails) = !GVAR(bulletTrails);
        _message = "Bullet trails have been toggled off";
        if(GVAR(bulletTrails)) then {_message = "Bullet trails have been toggled on"};
        systemChat _message;
    };
    case (_key == DIK_SPACE && _type == KEYDOWN) : {
        [] call FUNC(onModeSwitch);
        [] call FUNC(setTarget);
    };
    case (_key == DIK_U && _type == KEYDOWN) : {
        [] call FUNC(toggleUI);
    };
    case (_key in actionKeys "Chat") : {
        _done = false;
    };
    case (_key == DIK_P && _type == KEYDOWN) : {
      _time = ([time,true] call CFUNC(secondsToTime));
      systemChat format["Mission time: %1:%2:%3",_time select 0,_time select 1,_time select 2];
  };
  case (_key in (actionKeys "curatorInterface") && _type == KEYDOWN): {
        if(!isNull getAssignedCuratorLogic player) then {
            private _pos = getPos GVAR(camera);
            private _vectorUp = vectorUp GVAR(camera);
            private _vectorDir = vectorDir GVAR(camera);
            closeDialog 2;
            [_pos,_vectorUp,_vectorDir] spawn {
                params ["_pos", "_vectorUp", "_vectorDir"];
                sleep 0.1;
                openCuratorInterface;
                waitUntil {sleep 0.1;!isNull (findDisplay 312)}; // wait until open
                curatorCamera setPos _pos;
                curatorCamera setVectorDirAndUp [_vectorDir,_vectorUp];
                (findDisplay 312) displayAddEventHandler ["Unload",{GVAR(zeusPos) = getPos curatorCamera; GVAR(zeusDir) = getDir curatorCamera; GVAR(zeusPitchBank) = curatorCamera call BIS_fnc_getPitchBank;_this spawn FUNC(zeusUnload);}];
                sleep 0.5;
                curatorCamera setPos _pos;
                curatorCamera setVectorDirAndUp [_vectorDir,_vectorUp];
            };
        };
  };
  case default {
      _done =false;
      if(_type == KEYDOWN) then {
        [QGVAR(keyDown),_this] call CBA_fnc_localEvent;
      } else {
        [QGVAR(keyUp),_this] call CBA_fnc_localEvent;
      };
  };
};
_done
