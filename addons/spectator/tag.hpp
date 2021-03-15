class GVAR(Tag): ctrlControlsGroupNoScrollbars {
    idc = IDC_TMF_SPECTATOR_TAG;
    x = safezoneX;
    y = safezoneY;
    w = TAG_W;
    h = TAG_ICON_H + GRID_H * SIZE_M + GRID_H * SIZE_S;
	onMouseZChanged = QUOTE([ARR_2('MouseZChanged', _this)] call FUNC(mouseHandler));
    class controls {
        class GVAR(Icon): ctrlButtonPictureKeepAspect {
            idc = IDC_TMF_SPECTATOR_TAG_ICON;
            text = UNIT_ICON;
            x = (TAG_W - TAG_ICON_W) / 2;
            y = 0;
            w = TAG_ICON_W;
            h = TAG_ICON_H;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			onButtonClick = QUOTE([ARR_2('ButtonClick',_this)] call FUNC(mouseHandler));
        };
        class GVAR(Name): ctrlStatic {
            idc = IDC_TMF_SPECTATOR_TAG_NAME;
            style = ST_CENTER;
            x = 0;
            y = TAG_ICON_H;
            w = TAG_W;
            h = GRID_H * SIZE_M;
            sizeEx = SIZEEX_PURISTA(SIZEEX_M);
            shadow = 2;
        };
        class GVAR(Detail): GVAR(Name) {
            idc = IDC_TMF_SPECTATOR_TAG_DETAIL;
            y = TAG_ICON_H + GRID_H * SIZE_M;
            h = GRID_H * SIZE_S;
            sizeEx = SIZEEX_PURISTA(SIZEEX_S);
        };
    };
};
