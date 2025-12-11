module("modules.logic.necrologiststory.config.NecrologistStoryV3A1Config", package.seeall)

local var_0_0 = class("NecrologistStoryV3A1Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._openConfig = nil
	arg_1_0._opengroupConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"hero_story_mode_fugaoren_base",
		"hero_story_mode_fugaoren_story"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("onLoad%s", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.onLoadhero_story_mode_fugaoren_story(arg_4_0, arg_4_1)
	arg_4_0._fugaorenStoryConfig = arg_4_1
end

function var_0_0.onLoadhero_story_mode_fugaoren_base(arg_5_0, arg_5_1)
	arg_5_0._fugaorenBaseConfig = arg_5_1
end

function var_0_0.getStoryConfig(arg_6_0, arg_6_1)
	return arg_6_0._fugaorenStoryConfig.configDict[arg_6_1]
end

function var_0_0._initFugaorenGraphMap(arg_7_0)
	if arg_7_0._fugaorenBaseGraph then
		return
	end

	arg_7_0._fugaorenBaseGraph = {}
	arg_7_0._costTimeDict = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._fugaorenBaseConfig.configList) do
		local var_7_0 = arg_7_0._fugaorenBaseGraph[iter_7_1.id]

		if not var_7_0 then
			var_7_0 = {}
			arg_7_0._fugaorenBaseGraph[iter_7_1.id] = var_7_0
		end

		local var_7_1 = string.splitToNumber(iter_7_1.conArea, "#")

		for iter_7_2, iter_7_3 in ipairs(var_7_1) do
			var_7_0[iter_7_3] = true
		end

		arg_7_0._costTimeDict[iter_7_1.id] = {}

		local var_7_2 = arg_7_0._costTimeDict[iter_7_1.id]
		local var_7_3 = GameUtil.splitString2(iter_7_1.costTime, true)

		if var_7_3 then
			for iter_7_4, iter_7_5 in ipairs(var_7_3) do
				var_7_2[iter_7_5[1]] = iter_7_5[2]
			end
		end
	end
end

function var_0_0.hasBaseConnection(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:_initFugaorenGraphMap()

	local var_8_0 = arg_8_0:_checkBaseConnection(arg_8_1, arg_8_2)

	if var_8_0 then
		return true, var_8_0
	end

	return false
end

function var_0_0._checkBaseConnection(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == arg_9_2 then
		return false
	end

	local var_9_0 = arg_9_0:getFugaorenBaseCo(arg_9_1)
	local var_9_1 = arg_9_0:getFugaorenBaseCo(arg_9_2)
	local var_9_2 = arg_9_0._fugaorenBaseGraph[arg_9_1]

	if var_9_2 and var_9_2[arg_9_2] then
		local var_9_3 = arg_9_0._costTimeDict[arg_9_1] and arg_9_0._costTimeDict[arg_9_1][arg_9_2]

		var_9_3 = var_9_3 or arg_9_0._costTimeDict[arg_9_2] and arg_9_0._costTimeDict[arg_9_2][arg_9_1]

		return var_9_3 or 0
	end
end

function var_0_0.getFugaorenBaseCo(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._fugaorenBaseConfig.configDict[arg_10_1]

	if not var_10_0 then
		logError(string.format("FugaorenBaseCo is nil id:%s", arg_10_1))
	end

	return var_10_0
end

function var_0_0.getDefaultBaseId(arg_11_0)
	return 101
end

function var_0_0.getBaseList(arg_12_0)
	return arg_12_0._fugaorenBaseConfig.configList
end

function var_0_0.getBaseStoryList(arg_13_0, arg_13_1)
	if not arg_13_0._baseStoryList then
		arg_13_0._baseStoryList = {}

		for iter_13_0, iter_13_1 in ipairs(arg_13_0._fugaorenStoryConfig.configList) do
			if not arg_13_0._baseStoryList[iter_13_1.baseId] then
				arg_13_0._baseStoryList[iter_13_1.baseId] = {}
			end

			table.insert(arg_13_0._baseStoryList[iter_13_1.baseId], iter_13_1.id)
		end
	end

	return arg_13_0._baseStoryList[arg_13_1]
end

function var_0_0.getBaseTargetList(arg_14_0)
	if not arg_14_0._baseTargetList then
		arg_14_0._baseTargetList = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_0._fugaorenBaseConfig.configList) do
			if iter_14_1.endTime > 0 then
				table.insert(arg_14_0._baseTargetList, iter_14_1)
			end
		end
	end

	return arg_14_0._baseTargetList
end

function var_0_0.getBigBaseInArea(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._fugaorenBaseConfig.configList) do
		if iter_15_1.areaId == arg_15_1 and iter_15_1.type == NecrologistStoryEnum.BaseType.BigBase then
			return iter_15_1.id
		end
	end
end

function var_0_0.getCurStartTime(arg_16_0, arg_16_1)
	local var_16_0 = 1
	local var_16_1 = arg_16_0._fugaorenBaseConfig.configList

	if arg_16_1 then
		for iter_16_0 = #var_16_1, 1, -1 do
			local var_16_2 = var_16_1[iter_16_0]

			if arg_16_1 >= var_16_2.id and var_16_2.startTime > 0 then
				var_16_0 = iter_16_0

				break
			end
		end
	end

	local var_16_3 = var_16_1[var_16_0]

	return var_16_3.id, var_16_3.startTime
end

var_0_0.instance = var_0_0.New()

return var_0_0
