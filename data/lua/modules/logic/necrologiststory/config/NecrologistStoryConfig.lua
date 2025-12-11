module("modules.logic.necrologiststory.config.NecrologistStoryConfig", package.seeall)

local var_0_0 = class("NecrologistStoryConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._openConfig = nil
	arg_1_0._opengroupConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"hero_story_plot",
		"hero_story_plot_group",
		"hero_story_introduce",
		"hero_story_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.onhero_story_plot_groupLoaded(arg_4_0, arg_4_1)
	arg_4_0._heroStoryPlotGroupConfig = arg_4_1
end

function var_0_0.onhero_story_taskLoaded(arg_5_0, arg_5_1)
	arg_5_0._heroStoryTaskConfig = arg_5_1
end

function var_0_0.onhero_story_plotLoaded(arg_6_0, arg_6_1)
	arg_6_0._heroStoryMainConfig = arg_6_1
	arg_6_0._heroStoryMainDict = {}

	local var_6_0
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.configList) do
		local var_6_2 = arg_6_0._heroStoryMainDict[iter_6_1.storygroup]

		if not var_6_2 then
			var_6_2 = {}
			arg_6_0._heroStoryMainDict[iter_6_1.storygroup] = var_6_2
			var_6_0 = var_6_1
		end

		if iter_6_1.type == "selector" then
			var_6_0 = tonumber(iter_6_1.param)
		elseif iter_6_1.type == "selectorend" then
			var_6_0 = var_6_1
		else
			var_6_2[var_6_0] = var_6_2[var_6_0] or {}

			table.insert(var_6_2[var_6_0], iter_6_1)
		end
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0._heroStoryMainDict) do
		for iter_6_4, iter_6_5 in pairs(iter_6_3) do
			table.sort(iter_6_5, SortUtil.keyLower("id"))
		end
	end
end

function var_0_0.onhero_story_introduceLoaded(arg_7_0, arg_7_1)
	arg_7_0._heroStoryIntroduceConfig = arg_7_1
end

function var_0_0.getStoryListByGroupId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._heroStoryMainDict[arg_8_1]

	if not var_8_0 then
		logError(string.format("storygroup config list is nil, groupId:%s", arg_8_1))
	end

	return var_8_0
end

function var_0_0.getStoryConfig(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._heroStoryMainConfig.configDict[arg_9_1]

	if not var_9_0 and not arg_9_2 then
		logError(string.format("story config is nil, storyId:%s", arg_9_1))
	end

	return var_9_0
end

function var_0_0.getIntroduceCoByName(arg_10_0, arg_10_1)
	local var_10_0 = LangSettings.instance:getCurLang() or -1

	if not arg_10_0.introduceCoByName then
		arg_10_0.introduceCoByName = {}
	end

	if not arg_10_0.introduceCoByName[var_10_0] then
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_0._heroStoryIntroduceConfig.configList) do
			var_10_1[iter_10_1.name] = iter_10_1
		end

		arg_10_0.introduceCoByName[var_10_0] = var_10_1
	end

	local var_10_2 = arg_10_0.introduceCoByName[var_10_0][arg_10_1]

	if not var_10_2 then
		logError(string.format("名词说明 '%s' 不存在!!!", tostring(arg_10_1)))
	end

	return var_10_2
end

function var_0_0.getIntroduceCo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._heroStoryIntroduceConfig.configDict[arg_11_1]

	if not var_11_0 then
		logError(string.format("IntroduceConfig is nil id:%s", arg_11_1))
	end

	return var_11_0
end

function var_0_0.getTaskCo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._heroStoryTaskConfig.configDict[arg_12_1]

	if not var_12_0 then
		logError(string.format("TaskConfig is nil id:%s", arg_12_1))
	end

	return var_12_0
end

function var_0_0.getPlotGroupCo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._heroStoryPlotGroupConfig.configDict[arg_13_1]

	if not var_13_0 then
		logError(string.format("PlotGroupConfig is nil id:%s", arg_13_1))
	end

	return var_13_0
end

function var_0_0.getPlotListByStoryId(arg_14_0, arg_14_1)
	if not arg_14_0._plotListByStoryIdDict then
		arg_14_0._plotListByStoryIdDict = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_0._heroStoryPlotGroupConfig.configList) do
			if not arg_14_0._plotListByStoryIdDict[iter_14_1.storyId] then
				arg_14_0._plotListByStoryIdDict[iter_14_1.storyId] = {}
			end

			table.insert(arg_14_0._plotListByStoryIdDict[iter_14_1.storyId], iter_14_1)
		end
	end

	return arg_14_0._plotListByStoryIdDict[arg_14_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
