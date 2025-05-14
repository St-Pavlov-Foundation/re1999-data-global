module("modules.logic.versionactivity1_5.aizila.model.AiZiLaEquipMO", package.seeall)

local var_0_0 = pureTable("AiZiLaEquipMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.typeId = arg_1_1
	arg_1_0._equipId = arg_1_2 or 0
	arg_1_0.activityId = arg_1_3 or VersionActivity1_5Enum.ActivityId.AiZiLa
	arg_1_0._needUpdateConfig = true
end

function var_0_0.getConfig(arg_2_0)
	if arg_2_0._needUpdateConfig then
		arg_2_0._needUpdateConfig = false
		arg_2_0._config = AiZiLaConfig.instance:getEquipCo(arg_2_0.activityId, arg_2_0._equipId)
		arg_2_0._nexConfig = AiZiLaConfig.instance:getEquipCoByPreId(arg_2_0.activityId, arg_2_0._equipId, arg_2_0.typeId)
		arg_2_0._costParams = AiZiLaHelper.getCostParams(arg_2_0._nexConfig)
	end

	return arg_2_0._config
end

function var_0_0.getNextConfig(arg_3_0)
	arg_3_0:getConfig()

	return arg_3_0._nexConfig
end

function var_0_0.isMaxLevel(arg_4_0)
	return arg_4_0:getNextConfig() == nil
end

function var_0_0.isCanUpLevel(arg_5_0)
	arg_5_0:getConfig()

	if arg_5_0:isMaxLevel() or arg_5_0._costParams == nil then
		return false
	end

	return AiZiLaHelper.checkCostParams(arg_5_0._costParams)
end

function var_0_0.getCostParams(arg_6_0)
	arg_6_0:getConfig()

	return arg_6_0._costParams
end

function var_0_0.updateInfo(arg_7_0, arg_7_1)
	if arg_7_0._equipId ~= arg_7_1 then
		arg_7_0._equipId = arg_7_1
		arg_7_0._needUpdateConfig = true
	end
end

return var_0_0
