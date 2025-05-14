module("modules.logic.ressplit.config.ResSplitConfig", package.seeall)

local var_0_0 = class("ResSplitConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"app_include",
		"version_res_split"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "app_include" then
		arg_3_0._appIncludeConfig = arg_3_2
	end
end

function var_0_0.getAppIncludeConfig(arg_4_0)
	return arg_4_0._appIncludeConfig.configDict
end

function var_0_0.getMaxWeekWalkLayer(arg_5_0)
	if arg_5_0._maxLayer == nil then
		arg_5_0._maxLayer = 0

		for iter_5_0, iter_5_1 in pairs(arg_5_0._appIncludeConfig.configDict) do
			arg_5_0._maxLayer = math.max(arg_5_0._maxLayer, iter_5_1.maxWeekWalk)
		end
	end

	return arg_5_0._maxLayer
end

function var_0_0.getAllChapterIds(arg_6_0)
	if arg_6_0._allChapterIds == nil then
		arg_6_0._allChapterIds = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_0._appIncludeConfig.configDict) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1.chapter) do
				arg_6_0._allChapterIds[iter_6_3] = true
			end
		end
	end

	return arg_6_0._allChapterIds
end

function var_0_0.isSaveChapter(arg_7_0, arg_7_1)
	arg_7_0:getAllChapterIds()

	return arg_7_0._allChapterIds[arg_7_1]
end

function var_0_0.getAllCharacterIds(arg_8_0)
	if arg_8_0._allCharacterIds == nil then
		arg_8_0._allCharacterIds = {}

		for iter_8_0, iter_8_1 in pairs(arg_8_0._appIncludeConfig.configDict) do
			for iter_8_2, iter_8_3 in pairs(iter_8_1.character) do
				arg_8_0._allCharacterIds[iter_8_3] = true
			end
		end
	end

	return arg_8_0._allCharacterIds
end

var_0_0.instance = var_0_0.New()

return var_0_0
