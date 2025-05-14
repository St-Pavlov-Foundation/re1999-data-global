module("modules.logic.versionactivity1_3.buff.controller.VersionActivity1_3BuffController", package.seeall)

local var_0_0 = class("VersionActivity1_3BuffController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openBuffView(arg_3_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3BuffView)
end

function var_0_0.openFairyLandView(arg_4_0, arg_4_1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3FairyLandView, arg_4_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
