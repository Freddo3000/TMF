//--- Spectator
#define BUTTON_WIDTH (8 * GRID_W)
#define BUTTON_HEIGHT (8 * GRID_H)
#define BUTTON_Y (safezoneY + GRID_H)
#define COLUMN(V) (safezoneX + GRID_W + (BUTTON_WIDTH + GRID_W) * V))
#define SIDEBAR_WIDTH (120 * GRID_W)
#define COMPASS_WIDTH (40 * GRID_W)

class GVAR(dialog) : RscStandardDisplay {
    idd = IDD_TMF_SPECTATOR_DIALOG;
    movingEnable = 0;
    fadein = 0;
    fadeout = 0;
    duration = 1e+6;
	closeOnMissionEnd = 1;
    type = 0;
    controlsBackground[] = {
		QGVAR(UnitLabel),
		QGVAR(Compass)
	};
    onKeyDown = QUOTE([ARR_2(0,_this)] call FUNC(keyhandler));
    onKeyUp= QUOTE([ARR_2(1,_this)] call FUNC(keyhandler));
    onLoad = QUOTE(_this call FUNC(onLoad));
    onUnload = QUOTE(_this call FUNC(onUnload));
	onMouseZChanged = QUOTE([ARR_2('MouseZChanged', _this)] call FUNC(mouseHandler));
    class GVAR(UnitLabel): ctrlStatic {
        idc = IDC_TMF_SPECTATOR_UNITLABEL;
		style = ST_CENTER;
		color[] = {1,1,1,1};
		shadow = 1;
        x = CENTER_X - GRID_W * 20;
        y = safezoneY + GRID_H * 6;
        w = COMPASS_WIDTH;
        h = GRID_H * SIZE_XL;
		SizeEx = SIZEEX_PURISTA(SIZEEX_XL);
        font = "RobotoCondensedBold";
    };
    class GVAR(Compass): RscHorizontalCompass {
        idc = IDC_TMF_SPECTATOR_COMPASS;
        x = CENTER_X - GRID_W * 20;
        y = safezoneY + GRID_H;
        w = GRID_W * 40;
        h = GRID_H * SIZE_XL;
    };
    class controls {
        class GVAR(Filter): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_FILTER;
            x = COLUMN(1);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            onButtonDown = QUOTE([ARR_2('disableAI',_this)] call FUNC(menuhandler));
            text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayerSetup\enabledai_ca.paa";
            tooltip = "PLAYERS + AI";
        };
        class GVAR(Button): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_BUTTON;
            x = COLUMN(0);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_custom_ca.paa";
            onButtonDown = QUOTE([ARR_2('sidefilter',_this)] call FUNC(menuhandler));
            tooltip = "SHOWING ALL SIDES";
        };
        class GVAR(Tags): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_TAGS;
            x = COLUMN(3);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\A3\ui_f\data\map\Diary\textures_ca.paa";
            onButtonDown = QUOTE([ARR_2('tags',_this)] call FUNC(menuhandler));
            tooltip = "DISABLE TAGS";
        };
        class GVAR(Vision): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_VISION;
            x = COLUMN(4);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            onButtonDown = QUOTE([ARR_2('vision',_this)] call FUNC(menuhandler));
            text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\nvgs_ca.paa";
            tooltip = "CHANGE VISION MODE";
        };
        class GVAR(View): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_VIEW;
            onButtonDown = QUOTE([ARR_2('camera',_this)] call FUNC(menuhandler));
            x = COLUMN(2);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\A3\ui_f\data\IGUI\Cfg\IslandMap\iconcamera_ca.paa";
            tooltip = "SWITCH TO FIRST PERSON";
        };
        class GVAR(Mute): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_MUTE;
            onButtonDown = QUOTE([ARR_2('mute',_this)] call FUNC(menuhandler));
            x = COLUMN(5);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\voice_ca.paa";
            tooltip = "MUTE SPECTATORS";
        };
        class GVAR(Radio): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_RADIO;
            onButtonDown = QUOTE([ARR_2('radio',_this)] call FUNC(menuhandler));
            x = COLUMN(6);
            y = BUTTON_Y;
            w = BUTTON_WIDTH;
            h = BUTTON_HEIGHT;
            text = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
            tooltip = "SHOW RADIO MENU";
        };
        class GVAR(Map) : ctrlMap {
            idc = IDC_TMF_SPECTATOR_MAP;
            onDraw = QUOTE(_this call FUNC(drawMap));
            onMouseButtonDown = QUOTE(_this call FUNC(onMapClick));
        };
        class GVAR(UnitList): ctrlTree {
            idc = IDC_TMF_SPECTATOR_UNITLIST;
            x = safezoneX + GRID_W;
            y = BUTTON_Y + BUTTON_HEIGHT + GRID_H;
            w = SIDEBAR_WIDTH;
            h = safezoneY + safezoneH - BUTTON_Y - BUTTON_HEIGHT - 3 * GRID_H;
			sizeEx = SIZEEX_PURISTA(SIZEEX_XL);
			font = FONT_SEMIBOLD;
			borderSize = 0;
            shadow = 2;
            disableKeyboardSearch = 1;
			colorLines[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorSelect[] = {0,0,0,0};
            onTreeSelChanged = QUOTE(_this call FUNC(onChange));
            multiselectEnabled = 0;
            // Scrollbar configuration
            class ScrollBar: ScrollBar {
                width = 0;
                height = 0;
            };
            maxHistoryDelay = 9999999; // Time since last keyboard type search to reset it
        };
        class GVAR(KillList) : ctrlControlsGroupNoScrollbars {
            idc = IDC_TMF_SPECTATOR_KILLIST;
            x = safezoneW + safezoneX - SIDEBAR_WIDTH - GRID_W;
            y = safezoneY + GRID_H;
            w = SIDEBAR_WIDTH;
            h = 40 * GRID_H;
            colorBackground[] = {0,0,0,0.5};
            class controls {
                class Label1: ctrlStructuredText {
                    idc = IDC_TMF_SPECTATOR_KILLIST_L1;
                    x = 0;
                    y = 0;
                    w = SIDEBAR_WIDTH;
                    h = SIZE_XL * GRID_H;
                    style = ST_RIGHT;
					size = SIZEEX_PURISTA(SIZEEX_XL);
					font = FONT_SEMIBOLD;
					shadow = 2;
                    class Attributes {
                        align = "right";
                        valign = "middle";
                    };
                };
                class Label2: Label1 {
                    idc = IDC_TMF_SPECTATOR_KILLIST_L2;
                    y = 1 * SIZE_XL * GRID_H;
                };
                class Label3: Label1 {
                    idc = IDC_TMF_SPECTATOR_KILLIST_L3;
                    y = 2 * SIZE_XL * GRID_H;
                };
                class Label4: Label1 {
                    idc = IDC_TMF_SPECTATOR_KILLIST_L4;
                    y = 3 * SIZE_XL * GRID_H;
                };
                class Label5: Label1 {
                    idc = IDC_TMF_SPECTATOR_KILLIST_L5;
                    y = 4 * SIZE_XL * GRID_H;
                };
                class Label6: Label1 {
                    idc = IDC_TMF_SPECTATOR_KILLIST_L6;
					y = 5 * SIZE_XL * GRID_H;
                };
            };
        };
    };
};
