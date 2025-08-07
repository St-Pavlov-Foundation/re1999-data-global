module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonFull_Part1", package.seeall)

local var_0_0 = class("V2a9_VersionSummonFull_Part1", V2a9_VersionSummonFull)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageRole:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_fullrole1"))
	arg_1_0._simageLogo:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_logo1"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_title1"))
	arg_1_0._simageProp:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_icon_1"))

	arg_1_0._txtTips.text = luaLang("v2a9_versionsummon_txt_tips1")
end

return var_0_0
