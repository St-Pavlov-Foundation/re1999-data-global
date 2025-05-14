module("modules.logic.rouge.config.RougeFavoriteConfig", package.seeall)

local var_0_0 = class("RougeFavoriteConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_story_list",
		"rouge_illustration_list"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rouge_story_list" then
		arg_3_0:_initStoryList()
	elseif arg_3_1 == "rouge_illustration_list" then
		arg_3_0:_initIllustrationList()
	end
end

function var_0_0._initIllustrationList(arg_4_0)
	arg_4_0._illustrationList = {}
	arg_4_0._illustrationPages = {}
	arg_4_0._normalIllustrationPageCount = 0
	arg_4_0._dlcIllustrationPageCount = 0

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(lua_rouge_illustration_list.configList) do
		table.insert(var_4_0, iter_4_1)
	end

	table.sort(var_4_0, var_0_0._sortIllustration)

	local var_4_1 = 0

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		local var_4_2 = arg_4_0._illustrationPages[var_4_1]
		local var_4_3 = var_4_2 and #var_4_2 or 0
		local var_4_4 = var_4_3 >= RougeEnum.IllustrationNumOfPage
		local var_4_5 = var_4_2 and var_4_2[var_4_3]
		local var_4_6 = var_4_5 and var_4_5.config
		local var_4_7 = arg_4_0:isDLCIllustration(var_4_6)
		local var_4_8 = arg_4_0:isDLCIllustration(iter_4_3)
		local var_4_9 = var_4_7 == var_4_8

		if not var_4_2 or not var_4_9 or var_4_4 then
			var_4_1 = var_4_1 + 1
			arg_4_0._illustrationPages[var_4_1] = {}

			if var_4_8 then
				arg_4_0._dlcIllustrationPageCount = arg_4_0._dlcIllustrationPageCount + 1
			else
				arg_4_0._normalIllustrationPageCount = arg_4_0._normalIllustrationPageCount + 1
			end
		end

		local var_4_10 = string.splitToNumber(iter_4_3.eventId, "|")
		local var_4_11 = {
			config = iter_4_3,
			eventIdList = var_4_10
		}

		table.insert(arg_4_0._illustrationPages[var_4_1], var_4_11)
		table.insert(arg_4_0._illustrationList, var_4_11)
	end
end

function var_0_0._sortIllustration(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.instance:isDLCIllustration(arg_5_0)

	if var_5_0 ~= var_0_0.instance:isDLCIllustration(arg_5_1) then
		return not var_5_0
	end

	if arg_5_0.order ~= arg_5_1.order then
		return arg_5_0.order > arg_5_1.order
	end

	return arg_5_0.id < arg_5_1.id
end

function var_0_0.isDLCIllustration(arg_6_0, arg_6_1)
	return arg_6_1 and arg_6_1.dlc == 1
end

function var_0_0.getIllustrationList(arg_7_0)
	return arg_7_0._illustrationList
end

function var_0_0.getIllustrationPages(arg_8_0)
	return arg_8_0._illustrationPages
end

function var_0_0.getNormalIllustrationPageCount(arg_9_0)
	return arg_9_0._normalIllustrationPageCount
end

function var_0_0.getDLCIllustationPageCount(arg_10_0)
	return arg_10_0._dlcIllustrationPageCount
end

function var_0_0._initStoryList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(lua_rouge_story_list.configList) do
		table.insert(var_11_0, iter_11_1)
	end

	table.sort(var_11_0, var_0_0._sortStory)

	arg_11_0._storyList = {}
	arg_11_0._storyMap = {}

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_1 = {
			index = iter_11_2,
			config = iter_11_3,
			storyIdList = string.splitToNumber(iter_11_3.storyIdList, "#")
		}

		table.insert(arg_11_0._storyList, var_11_1)

		local var_11_2 = var_11_1.storyIdList[#var_11_1.storyIdList]

		arg_11_0._storyMap[var_11_2] = true
	end
end

function var_0_0._sortStory(arg_12_0, arg_12_1)
	if arg_12_0.stageId ~= arg_12_1.stageId then
		return arg_12_0.stageId < arg_12_1.stageId
	end

	return arg_12_0.id < arg_12_1.id
end

function var_0_0.getStoryList(arg_13_0)
	return arg_13_0._storyList
end

function var_0_0.inRougeStoryList(arg_14_0, arg_14_1)
	return arg_14_0._storyMap and arg_14_0._storyMap[arg_14_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
