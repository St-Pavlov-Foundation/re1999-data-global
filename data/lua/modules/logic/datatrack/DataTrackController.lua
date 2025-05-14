module("modules.logic.datatrack.DataTrackController", package.seeall)

local var_0_0 = class("DataTrackController", BaseController)

function var_0_0.onInit(arg_1_0)
	SDKDataTrackExt.activateExtend()
end

var_0_0.instance = var_0_0.New()

return var_0_0
