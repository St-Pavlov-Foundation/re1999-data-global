module("modules.logic.versionactivity2_8.decalogpresent.define.DecalogPresentViewDefine", package.seeall)

local var_0_0 = class("DecalogPresentViewDefine")

function var_0_0.init(arg_1_0)
	var_0_0.initV2a8(arg_1_0)
end

function var_0_0.initV2a8(arg_2_0)
	arg_2_0.V2a8DecalogPresentView = {
		destroy = 0,
		container = "V2a8DecalogPresentViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_8/v2a8_versionsummon/v2a8_versionsummon.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	arg_2_0.V2a8DecalogPresentFullView = {
		destroy = 0,
		container = "V2a8DecalogPresentFullViewContainer",
		mainRes = "ui/viewres/versionactivity_2_8/v2a8_versionsummon/v2a8_versionsummonfull.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return var_0_0
