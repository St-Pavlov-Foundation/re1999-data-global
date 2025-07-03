module("modules.logic.tower.model.TowerBossTeachModel", package.seeall)

local var_0_0 = class("TowerBossTeachModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.lastFightTeachId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.lastFightTeachId = 0
end

function var_0_0.isAllEpisodeFinish(arg_3_0, arg_3_1)
	local var_3_0 = TowerConfig.instance:getAssistBossConfig(arg_3_1)
	local var_3_1 = TowerConfig.instance:getAllBossTeachConfigList(var_3_0.towerId)
	local var_3_2 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Boss, var_3_0.towerId)

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		if var_3_2 and not var_3_2:isPassBossTeach(iter_3_1.teachId) then
			return false
		end
	end

	return true
end

function var_0_0.getTeachFinishEffectSaveKey(arg_4_0, arg_4_1)
	return string.format("%s_%s", TowerEnum.LocalPrefsKey.TowerBossTeachFinishEffect, arg_4_1)
end

function var_0_0.setLastFightTeachId(arg_5_0, arg_5_1)
	arg_5_0.lastFightTeachId = arg_5_1
end

function var_0_0.getLastFightTeachId(arg_6_0)
	return arg_6_0.lastFightTeachId
end

function var_0_0.getFirstUnFinishTeachId(arg_7_0, arg_7_1)
	local var_7_0 = TowerConfig.instance:getAssistBossConfig(arg_7_1)
	local var_7_1 = TowerConfig.instance:getAllBossTeachConfigList(var_7_0.towerId)
	local var_7_2 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Boss, var_7_0.towerId)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if var_7_2 and not var_7_2:isPassBossTeach(iter_7_1.teachId) then
			return iter_7_1.teachId
		end
	end

	return var_7_1[1].teachId
end

var_0_0.instance = var_0_0.New()

return var_0_0
