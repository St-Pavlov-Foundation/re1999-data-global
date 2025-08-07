module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonPanel_Part2", package.seeall)

local var_0_0 = class("V2a9_VersionSummonPanel_Part2", V2a9_VersionSummonPanel)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageRole:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_panelrole2"))
	arg_1_0._simageLogo:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_logo2"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a9VersionSummonSingleBgLang("v2a9_versionsummon_title2"))
	arg_1_0._simageProp:LoadImage(ResUrl.getV2a9VersionSummonSingleBg("v2a9_versionsummon_icon_2"))

	arg_1_0._txtTips.text = luaLang("v2a9_versionsummon_txt_tips2")
end

return var_0_0
