module("modules.logic.endofdream.model.EndOfDreamModel", package.seeall)

local var_0_0 = class("EndOfDreamModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear()
end

function var_0_0.isLevelUnlocked(arg_4_0, arg_4_1)
	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
