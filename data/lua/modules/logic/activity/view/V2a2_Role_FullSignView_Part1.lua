﻿module("modules.logic.activity.view.V2a2_Role_FullSignView_Part1", package.seeall)

local var_0_0 = class("V2a2_Role_FullSignView_Part1", V2a2_Role_FullSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageFullBG:LoadImage(ResUrl.getV2a2SignSingleBg("v2a2_sign_fullbg1"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, true)
	gohelper.setActive(var_1_1, false)
end

return var_0_0
