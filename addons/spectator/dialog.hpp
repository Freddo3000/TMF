
class RscText;
class RscMapControl;
class RscTree;
class RscControlsGroup;
class IGUIBack;
class RscButtonMenuOK;
class RscTitle;
class RscStructuredText;
class RscDebugConsole;
class RscPicture;
class RscXSliderH;
class ctrlControlsGroupNoScrollbars;
class RscControlsGroupNoScrollbars;

class RscSpectatorText : RscText {
    type = 0;
    style = 0x02;
    shadow = 1;
};
class RscSpectatorShortcutButton : RscPicture {
    type = 1;
    shadow = 0;
    colorBorder[] = {0,0,0,1};
    borderSize = 0;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    colorText[] = {1,1,1,1};
    colorFocused[] = {1,1,1,1};
    colorShadow[] = {1,1,1,1};
    colorDisabled[] = {0,0,0,1};
    colorBackground[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,1};
    colorBackgroundActive[] = {0,0,0,1};

    soundEnter[] = { "", 0, 1 };  // no sound
    soundPush[] = { "buttonpushed.ogg", 0.1, 1 };
    soundClick[] = { "", 0, 1 };  // no sound
    soundEscape[] = { "", 0, 1 };  // no sound
};

//--- Spectator
#define BUTTON_WIDTH 0.02 * safezoneW
#define BUTTON_HEIGHT 0.031 * safezoneH
#define COLUMN(V) (0.002 * safezoneW + safezoneX)+((0.0215 * safezoneW)  * V)

class GVAR(dialog) {
    idd = DISPLAY_ID;
    movingEnable = 1;
    enableSimulation = 1;
    enableDisplay = 1;
    fadein = 0;
    fadeout = 0;
    duration = 2147483647;
    type = 0;
    controlsBackground[] = {TMF_SPECTATOR_MOUSE,TMF_SPECTATOR_UNITLABEL,TMF_SPECTATOR_Compass,TMF_SPECTATOR_CompassLeft,TMF_SPECTATOR_CompassRight};
    onKeyDown = QUOTE([ARR_2(0,_this)] call FUNC(keyhandler));
    onKeyUp= QUOTE([ARR_2(1,_this)] call FUNC(keyhandler));
    onLoad = QUOTE(_this call FUNC(onLoad));
    onUnload = QUOTE(GVAR(camera) cameraEffect [ARR_2('TERMINATE','BACK')]);
    class GVAR(UNITLABEL): RscSpectatorText {
        idc = IDC_SPECTATOR_TMF_SPECTATOR_UNITLABEL;
        text = ""; //--- ToDo: Localize;
        x = (0.50-0.15/2) * safezoneW + safezoneX;
        y = 0.025 * safezoneH + safezoneY;
        w = 0.15 * safezoneW;
        h = 0.020 * safezoneH;
        font = "PuristaSemiBold";
    };
    class GVAR(Compass): RscSpectatorText {
        idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASS;
        text = "NW"; //--- ToDo: Localize;
        x = (0.5-(0.07/2)) * safezoneW + safezoneX;
        y = 0.005* safezoneH + safezoneY;
        w = 0.07 * safezoneW;
        h = 0.015 * safezoneH;
        font = "PuristaBold";
    };
    class GVAR(CompassLeft): RscSpectatorText {
        idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASSLEFT;
        text = "NW"; //--- ToDo: Localize;
        x = (0.5-(0.14)/2) * safezoneW + safezoneX;
        y = 0.005 * safezoneH + safezoneY;
        w = 0.07 * safezoneW;
        h = 0.015 * safezoneH;
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
        colorText[] = {1, 1, 1, 0.7};
        font = "PuristaBold";
    };
    class GVAR(CompassRight): RscSpectatorText {
        idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASSRight;
        text = "NE"; //--- ToDo: Localize;
        x = (0.5) * safezoneW + safezoneX;
        y = 0.005 * safezoneH + safezoneY;
        w = 0.07 * safezoneW;
        h = 0.015 * safezoneH;
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
        colorText[] = {1, 1, 1, 0.7};
        font = "PuristaBold";
    };
    class controls {
        class GVAR(FILTER): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_FILTER;
            x = COLUMN(1);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            onButtonDown = QUOTE([ARR_2('disableAI',_this)] call FUNC(menuhandler));
            text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayerSetup\enabledai_ca.paa";
            tooltip = "PLAYERS + AI";
        };
        class GVAR(BUTTON): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_BUTTON;
            x = COLUMN(0);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = QPATHTOF(images\flag_civil_empty_ca_64.paa);
            onButtonDown = QUOTE([ARR_2('sidefilter',_this)] call FUNC(menuhandler));
            tooltip = "SHOWING ALL SIDES";
        };
        class GVAR(TAGS): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_TAGS;
            x = COLUMN(3);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\A3\ui_f\data\map\Diary\textures_ca.paa";
            onButtonDown = QUOTE([ARR_2('tags',_this)] call FUNC(menuhandler));
            tooltip = "DISABLE TAGS";
        };
        class GVAR(VISION): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_VISION;
            x = COLUMN(4);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            onButtonDown = QUOTE([ARR_2('vision',_this)] call FUNC(menuhandler));
            text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\nvgs_ca.paa";
            tooltip = "CHANGE VISION MODE";
        };
        class GVAR(VIEW): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_VIEW;
            onButtonDown = QUOTE([ARR_2('camera',_this)] call FUNC(menuhandler));
            x = COLUMN(2);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\A3\ui_f\data\IGUI\Cfg\IslandMap\iconcamera_ca.paa";
            tooltip = "SWITCH TO FIRST PERSON";
        };
        class GVAR(MUTE): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_MUTE;
            onButtonDown = QUOTE([ARR_2('mute',_this)] call FUNC(menuhandler));
            x = COLUMN(5);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\voice_ca.paa";
            tooltip = "MUTE SPECTATORS";
        };
        class GVAR(RADIO): RscSpectatorShortcutButton {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_RADIO;
            onButtonDown = QUOTE([ARR_2('radio',_this)] call FUNC(menuhandler));
            x = COLUMN(6);
            y = 0.002 * safezoneH + safezoneY;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
            tooltip = "SHOW RADIO MENU";
        };
        class GVAR(MAP) : RscMapControl {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_MAP;
            x = 0 * safezoneW + safezoneX;
            y = 0 * safezoneH + safezoneY;
            w = 1 * safezoneW;
            h = 1 * safezoneH;
            onDraw = QUOTE(_this call FUNC(drawMap));
            onMouseButtonDown = QUOTE(_this call FUNC(onMapClick));
        };
        class GVAR(UNITLIST): RscTree {
            idc = IDC_SPECTATOR_TMF_SPECTATOR_UNITLIST;
            x = 0.002 * safezoneW + safezoneX;
            y = 0.038 * safezoneH + safezoneY;
            w = 0.13 * safezoneW;
            h = 0.940001 * safezoneH;
            shadow = 2;
            colorBackground[] = {0,0,0,0};
            disableKeyboardSearch = 1;
            colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)
            onTreeSelChanged = QUOTE(_this call FUNC(onChange));
            multiselectEnabled = 0;
            //onMouseZChanged = "[""MouseZChanged"",_this] call tmf_spectator_fnc_mouseHandler";
            // Scrollbar configuration
            class ScrollBar {
                width = 0;
                height = 0;
                scrollSpeed = 0.01;

                arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
                arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
                border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
                thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";

                color[] = {1,1,1,0}; // Scrollbar color
            };
            maxHistoryDelay = 9999999; // Time since last keyboard type search to reset it
        };
        class GVAR(KILLLIST) : RscControlsGroupNoScrollbars {
            idc = 2300;
            x = 0.763544 * safezoneW + safezoneX;
            y = 0.005 * safezoneH + safezoneY;
            w = 0.233576 * safezoneW;
            h = (0.020*6.5) * safezoneH;
            style = 16;
            action = "";
            colorBackground[] = {1,0,0,1};
            onMouseButtonDown = "true";
            onMouseButtonUp = "true";
            class controls {
                class dummy : RscText {
                    // REQUIRED
                    idc = -1;
                    x = 0.0 * safezoneW;
                    y = -5.0 * safezoneH;
                };
                class Label1: RscStructuredText {
                    idc = 6;
                    action = "";
                    x = 0.00352533 * safezoneW;
                    y = 0.0 * safezoneH;
                    w = 0.230 * safezoneW;
                    h = 0.020 * safezoneH;
                    colorBackground[] = {0,0,0,0.0};
                    text = "";
                    style = 0x01;
                    class Attributes {
                        align = "right";
                        valign = "middle";
                    };
                };
                class Label2: Label1 {
                    idc = 7;
                    x = 0.00352533 * safezoneW;
                    y = (0.020*1) * safezoneH;
                    w = 0.230 * safezoneW;
                    h = 0.020 * safezoneH;
                    colorBackground[] = {0,0,0,0.0};
                    action = "";
                };
                class Label3: Label1 {
                    idc = 8;
                    x = 0.00352533 * safezoneW;
                    y = (0.020*2) * safezoneH;
                    w = 0.230 * safezoneW;
                    h = 0.020 * safezoneH;
                    colorBackground[] = {0,0,0,0.0};
                    action = "";
                };
                class Label4: Label1 {
                    idc = 9;
                    x = 0.00352533 * safezoneW;
                    y = (0.020*3) * safezoneH;
                    w = 0.230 * safezoneW;
                    h = 0.020 * safezoneH;
                    colorBackground[] = {0,0,0,0.0};
                    action = "";
                };
                class Label5: Label1 {
                    idc = 10;
                    x = 0.00352533 * safezoneW;
                    y = (0.020*4) * safezoneH;
                    w = 0.230 * safezoneW;
                    h = 0.020 * safezoneH;
                    colorBackground[] = {0,0,0,0.0};
                    action = "";
                };
                class Label6: Label1 {
                    idc = 11;
                    x = 0.00352533 * safezoneW;
                    y = (0.020*5) * safezoneH;
                    w = 0.230 * safezoneW;
                    h = 0.020 * safezoneH;
                    colorBackground[] = {0,0,0,0.0};
                    action = "";
                };
            };
        };
    };
    class GVAR(MOUSE): RscControlsGroup {
        class ListScrollBar {
            color[] = {1,1,1,0.6};
            colorActive[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,0.0};
            thumb = "";
            arrowFull = "";
            arrowEmpty = "";
            border = "";
        };
        onMouseButtonDown = QUOTE([ARR_2('MouseButtonDown',_this)] call FUNC(mouseHandler));
        onMouseButtonUp = QUOTE([ARR_2('MouseButtonUp',_this)] call FUNC(mouseHandler));
        onMouseZChanged = QUOTE([ARR_2('MouseZChanged',_this)] call FUNC(mouseHandler));
        onMouseMoving = QUOTE([ARR_2('MouseMoving',_this)] call FUNC(mouseHandler));
        idc = 123;
        x = SafeZoneX; y = SafeZoneY;
        w = SafeZoneW; h = SafeZoneH;
        colorBackground[] = {0.2, 0.0, 0.0, 0.0};
    };
};
