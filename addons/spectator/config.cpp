#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Spectator";
        author = "Head";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

class CfgRespawnTemplates
{
    class ADDON
    {
        displayName = "TMF Spectator";
        onPlayerRespawn  = QFUNC(init);
        onPlayerKilled = "";
    };
};
#include "autotest.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\macroexecs.inc"
#include "\a3\3den\UI\resincl.inc"

class ctrlStatic;
class ctrlStructuredText;
class ctrlControlsGroupNoScrollbars;
class RscStandardDisplay;
class ctrlButtonPictureKeepAspect;
class ctrlDefault;
class ctrlMap : ctrlDefault {
    class Legend;
};
class ctrlDefaultText;
class ctrlTree: ctrlDefaultText {
    class ScrollBar;
};
class ctrlControlsGroup;
class RscHorizontalCompass;
class ctrlStaticPicture;
class ctrlStaticPictureKeepAspect;

#include "dialog.hpp"
#include "tag.hpp"
