module("modules.logic.jump.model.JumpModel", package.seeall)

local var_0_0 = class("JumpModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._recordFarmItem = nil
	arg_2_0.jumpFromFightScene = nil
	arg_2_0.jumpFromFightSceneParam = nil
end

function var_0_0.setRecordFarmItem(arg_3_0, arg_3_1)
	arg_3_0._recordFarmItem = arg_3_1
end

function var_0_0.getRecordFarmItem(arg_4_0)
	return arg_4_0._recordFarmItem
end

function var_0_0.clearRecordFarmItem(arg_5_0)
	arg_5_0._recordFarmItem = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
