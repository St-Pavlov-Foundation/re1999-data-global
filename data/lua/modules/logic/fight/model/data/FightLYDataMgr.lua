module("modules.logic.fight.model.data.FightLYDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightLYDataMgr")

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.LYCardAreaSize = 0
	arg_1_0.LYPointAreaSize = 0
	arg_1_0.pointList = nil
end

function var_0_0.setLYCardAreaBuff(arg_2_0, arg_2_1)
	arg_2_0.cardAreaBuff = arg_2_1
	arg_2_0.LYCardAreaSize = 0

	local var_2_0 = arg_2_1 and arg_2_1:getCO()
	local var_2_1 = FightBuffHelper.getFeatureList(var_2_0, FightEnum.BuffType_CardAreaRedOrBlue)

	if var_2_1 then
		arg_2_0.LYCardAreaSize = tonumber(var_2_1[2])
	end

	FightController.instance:dispatchEvent(FightEvent.LY_CardAreaSizeChange)
end

function var_0_0.getCardColor(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = (arg_3_1 and #arg_3_1 or 0) - arg_3_2 < arg_3_0.LYCardAreaSize
	local var_3_1 = arg_3_2 <= arg_3_0.LYCardAreaSize

	if var_3_0 and var_3_1 then
		return FightEnum.CardColor.Both
	end

	if var_3_0 then
		return FightEnum.CardColor.Blue
	end

	if var_3_1 then
		return FightEnum.CardColor.Red
	end

	return FightEnum.CardColor.None
end

function var_0_0.setLYCountBuff(arg_4_0, arg_4_1)
	arg_4_0.countBuff = arg_4_1

	arg_4_0:refreshPointList()
	arg_4_0:refreshShowAreaSize()
end

function var_0_0.setLYChangeTriggerBuff(arg_5_0, arg_5_1)
	arg_5_0.changeTriggerBuff = arg_5_1

	arg_5_0:refreshShowAreaSize()
end

function var_0_0.refreshShowAreaSize(arg_6_0)
	arg_6_0.LYPointAreaSize = 0

	if arg_6_0.countBuff then
		local var_6_0 = arg_6_0.countBuff:getCO()
		local var_6_1 = FightBuffHelper.getFeatureList(var_6_0, FightEnum.BuffType_RedOrBlueCount)

		if var_6_1 then
			arg_6_0.LYPointAreaSize = tonumber(var_6_1[2])
		end

		if arg_6_0.changeTriggerBuff then
			local var_6_2 = arg_6_0.changeTriggerBuff:getCO()
			local var_6_3 = FightBuffHelper.getFeatureList(var_6_2, FightEnum.BuffType_RedOrBlueChangeTrigger)

			if var_6_3 then
				local var_6_4 = tonumber(var_6_3[2]) or 0

				arg_6_0.LYPointAreaSize = arg_6_0.LYPointAreaSize + var_6_4 * arg_6_0.changeTriggerBuff.layer
			end
		end
	end

	FightController.instance:dispatchEvent(FightEvent.LY_PointAreaSizeChange)
end

function var_0_0.getPointList(arg_7_0)
	return arg_7_0.pointList
end

function var_0_0.refreshPointList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.pointList and #arg_8_0.pointList or 0

	if not arg_8_0.countBuff then
		arg_8_0.pointList = nil

		FightController.instance:dispatchEvent(FightEvent.LY_HadRedAndBluePointChange, arg_8_0.pointList, var_8_0)

		return
	end

	if not arg_8_1 and var_8_0 > #FightStrUtil.instance:getSplitToNumberCache(arg_8_0.countBuff.actCommonParams, "#") then
		return
	end

	local var_8_1 = FightStrUtil.instance:getSplitToNumberCache(arg_8_0.countBuff.actCommonParams, "#")

	arg_8_0.pointList = tabletool.copy(var_8_1)

	table.remove(arg_8_0.pointList, 1)
	FightController.instance:dispatchEvent(FightEvent.LY_HadRedAndBluePointChange, arg_8_0.pointList, var_8_0)
end

function var_0_0.hasCountBuff(arg_9_0)
	return arg_9_0.countBuff ~= nil
end

return var_0_0
