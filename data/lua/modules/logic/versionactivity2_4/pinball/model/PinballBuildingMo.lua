module("modules.logic.versionactivity2_4.pinball.model.PinballBuildingMo", package.seeall)

local var_0_0 = pureTable("PinballBuildingMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.configId
	arg_1_0.level = arg_1_1.level
	arg_1_0.index = arg_1_1.index
	arg_1_0.food = arg_1_1.food
	arg_1_0.interact = arg_1_1.interact

	arg_1_0:refreshCo()
end

function var_0_0.refreshCo(arg_2_0)
	local var_2_0 = lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_2_0.configId]

	if not var_2_0 then
		logError("没有建筑配置" .. tostring(arg_2_0.configId))

		return
	end

	arg_2_0.co = var_2_0[arg_2_0.level]
	arg_2_0.baseCo = var_2_0[1]
	arg_2_0.nextCo = var_2_0[arg_2_0.level + 1]
	arg_2_0._foodCost = 0
	arg_2_0._playDemand = 0

	if arg_2_0.co then
		local var_2_1 = GameUtil.splitString2(arg_2_0.co.effect, true) or {}

		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			if iter_2_1[1] == PinballEnum.BuildingEffectType.CostFood then
				arg_2_0._foodCost = arg_2_0._foodCost + iter_2_1[2]
			elseif iter_2_1[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				arg_2_0._playDemand = arg_2_0._playDemand + iter_2_1[2]
			end
		end
	end
end

function var_0_0.upgrade(arg_3_0)
	arg_3_0.level = arg_3_0.level + 1

	arg_3_0:refreshCo()
end

function var_0_0.isMainCity(arg_4_0)
	return arg_4_0.co.type == PinballEnum.BuildingType.MainCity
end

function var_0_0.isTalent(arg_5_0)
	return arg_5_0.co.type == PinballEnum.BuildingType.Talent
end

function var_0_0.getFoodCost(arg_6_0)
	return arg_6_0._foodCost
end

function var_0_0.getPlayDemand(arg_7_0)
	return arg_7_0._playDemand
end

return var_0_0
