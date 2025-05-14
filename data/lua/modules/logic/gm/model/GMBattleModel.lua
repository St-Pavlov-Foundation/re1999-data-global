module("modules.logic.gm.model.GMBattleModel", package.seeall)

local var_0_0 = class("GMBattleModel")

function var_0_0.setBattleParam(arg_1_0, arg_1_1)
	arg_1_0._battleParam = arg_1_1
end

function var_0_0.getBattleParam(arg_2_0)
	return arg_2_0._battleParam
end

function var_0_0.setGMFightRecordEnable(arg_3_0)
	arg_3_0.enableGMFightRecord = true
end

function var_0_0.setGMFightRecord(arg_4_0, arg_4_1)
	arg_4_0.fightRecordMsg = arg_4_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
