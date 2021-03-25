#include "\x\tmf\addons\spectator\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_spectator_fnc_isOpen

Description:
    Check whether TMF spectator UI is open

Examples:
    (begin example)
        _isOpen = [] call TMF_spectator_fnc_isOpen
    (end)

Returns:
    Boolean, whether spectator UI is open
---------------------------------------------------------------------------- */

!isNull findDisplay IDD_TMF_SPECTATOR_DIALOG
