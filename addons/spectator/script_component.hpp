#define COMPONENT spectator
#define DEBUG_MODE_FULL 1

#include "\x\tmf\addons\main\script_mod.hpp"
#include "\x\tmf\addons\main\script_macros.hpp"

#include "\a3\3DEN\UI\macros.inc"

#define TAG_ICON_W (6 * GRID_W)
#define TAG_ICON_H (6 * GRID_H)
#define TAG_W (10 * GRID_W + TAG_ICON_W + 10 * GRID_W)

#define FOLLOWCAM 0
#define FREECAM 1
#define FIRSTPERSON 2
#define MAP_FONTSIZE 0.04
#define MAP_FONT "RobotoCondensedLight"
#define UNIT_ICON "\a3\ui_f\data\map\markers\military\triangle_CA.paa"
#define VEHICLE_ICON "\a3\ui_f\data\map\Markers\military\box_CA.paa"
#define GROUP_ICON "\A3\ui_f\data\map\markers\nato\b_unknown.paa"
#define KIA_ICON "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"
#define CAMERA_ICON "\A3\ui_f\data\GUI\Rsc\RscDisplayMissionEditor\iconCamera_ca.paa"
#define MISSILE_ICON "\x\tmf\addons\spectator\images\missile.paa"
#define GRENADE_ICON "\x\tmf\addons\spectator\images\grenade.paa"
#define SMOKE_ICON "\x\tmf\addons\spectator\images\smokegrenade.paa"

#define TAGTYPE_GROUP 1
#define TAGTYPE_UNIT 2
#define TAGTYPE_VEHICLE 3

#define IDD_TMF_SPECTATOR_DIALOG        5454

#define IDC_TMF_SPECTATOR_UNITLABEL     4945
#define IDC_TMF_SPECTATOR_UNITLIST      7171
#define IDC_TMF_SPECTATOR_VISION        5545
#define IDC_TMF_SPECTATOR_FILTER        5546
#define IDC_TMF_SPECTATOR_BUTTON        5547
#define IDC_TMF_SPECTATOR_TAGS          5548
#define IDC_TMF_SPECTATOR_VIEW          5549

#define IDC_TMF_SPECTATOR_COMPASS       5453
#define IDC_TMF_SPECTATOR_MUTE          5467
#define IDC_TMF_SPECTATOR_MAP           5468
#define IDC_TMF_SPECTATOR_RADIO         5469

#define IDC_TMF_SPECTATOR_MENUBACK      6145
#define IDC_TMF_SPECTATOR_KILLIST       2300
#define IDC_TMF_SPECTATOR_KILLIST_L1    2301
#define IDC_TMF_SPECTATOR_KILLIST_L2    2302
#define IDC_TMF_SPECTATOR_KILLIST_L3    2303
#define IDC_TMF_SPECTATOR_KILLIST_L4    2304
#define IDC_TMF_SPECTATOR_KILLIST_L5    2305
#define IDC_TMF_SPECTATOR_KILLIST_L6    2306

#define IDC_TMF_SPECTATOR_TAG           2400
#define IDC_TMF_SPECTATOR_TAG_ICON      2401
#define IDC_TMF_SPECTATOR_TAG_NAME      2402
#define IDC_TMF_SPECTATOR_TAG_DETAIL    2403

#define TAG_ICON_CTRL(x) (x controlsGroupCtrl IDC_TMF_SPECTATOR_TAG_ICON)
#define TAG_NAME_CTRL(x) (x controlsGroupCtrl IDC_TMF_SPECTATOR_TAG_NAME)
#define TAG_DETAIL_CTRL(x) (x controlsGroupCtrl IDC_TMF_SPECTATOR_TAG_DETAIL)
#define GET_TAG(x) (x getVariable ['GVAR(tagControl)', controlNull])
#define GET_ATTACHED(x) (x getVariable ['GVAR(attached)', objNull])
