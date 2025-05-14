module("modules.logic.versionactivity.model.VersionActivityLeiMiTeBeiTaskModel", package.seeall)

local var_0_0 = class("VersionActivityLeiMiTeBeiTaskModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.infosDic = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

var_0_0.instance = var_0_0.New()

return var_0_0
