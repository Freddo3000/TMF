#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_addItems
 * Author = Nick
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of items to add
 *
 * Return:
 * 0: ARRAY. Array of items that could not be added
 *
 * Description:
 * Tries to add items to a units' inventory
 */
params ["_unit","_items"];
private _overflow = [];

if (isNil "_unit" || isNil "_items") exitWith {};

{
    switch true do {
        case (isNil "_x"): {};
        case ([_unit, _x, 1, true, false, false] call CBA_fnc_canAddItem): {_unit addItemToUniform _x;};
        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x;};
        default {_overflow pushBack _x};
    };
} forEach _items;

_overflow
