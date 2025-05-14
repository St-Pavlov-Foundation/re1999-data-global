module("modules.logic.open.config.OpenConfig", package.seeall)

local var_0_0 = class("OpenConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._openConfig = nil
	arg_1_0._opengroupConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"open",
		"open_group",
		"open_lang"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "open" then
		arg_3_0._openConfig = arg_3_2

		arg_3_0:_initOpenConfig()
	elseif arg_3_1 == "open_group" then
		arg_3_0._opengroupConfig = arg_3_2

		arg_3_0:_initOpenGroupConfig()
	elseif arg_3_1 == "open_lang" then
		arg_3_0._openglangConfig = arg_3_2

		arg_3_0:_initOpenLangConfig()
	end
end

function var_0_0._initOpenConfig(arg_4_0)
	arg_4_0._openShowInEpisodeList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._openConfig.configList) do
		if iter_4_1.showInEpisode == 1 then
			local var_4_0 = arg_4_0._openShowInEpisodeList[iter_4_1.episodeId] or {}

			arg_4_0._openShowInEpisodeList[iter_4_1.episodeId] = var_4_0

			table.insert(var_4_0, iter_4_1.id)
		end
	end
end

function var_0_0._initOpenGroupConfig(arg_5_0)
	arg_5_0._openGroupShowInEpisodeList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._opengroupConfig.configList) do
		if iter_5_1.showInEpisode == 1 then
			local var_5_0 = arg_5_0._openGroupShowInEpisodeList[iter_5_1.need_episode] or {}

			arg_5_0._openGroupShowInEpisodeList[iter_5_1.need_episode] = var_5_0

			table.insert(var_5_0, iter_5_1.id)
		end
	end
end

function var_0_0._initOpenLangConfig(arg_6_0)
	arg_6_0._openLangTxtsDic = {}
	arg_6_0._openLangVoiceDic = {}
	arg_6_0._openLangStoryVoiceDic = {}

	local var_6_0 = arg_6_0._openglangConfig.configList[1]
	local var_6_1 = string.split(var_6_0.langTxts, "#")
	local var_6_2 = string.split(var_6_0.langVoice, "#")
	local var_6_3 = string.split(var_6_0.langStoryVoice, "#")

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		arg_6_0._openLangTxtsDic[iter_6_1] = true
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_2) do
		arg_6_0._openLangVoiceDic[iter_6_3] = true
	end

	for iter_6_4, iter_6_5 in ipairs(var_6_3) do
		arg_6_0._openLangStoryVoiceDic[iter_6_5] = true
	end
end

function var_0_0.isOpenLangTxt(arg_7_0, arg_7_1)
	return arg_7_0._openLangTxtsDic[arg_7_1]
end

function var_0_0.isOpenLangVoice(arg_8_0, arg_8_1)
	return arg_8_0._openLangVoiceDic[arg_8_1]
end

function var_0_0.isOpenLangStoryVoice(arg_9_0, arg_9_1)
	return arg_9_0._openLangStoryVoiceDic[arg_9_1]
end

function var_0_0.getOpenShowInEpisode(arg_10_0, arg_10_1)
	return arg_10_0._openShowInEpisodeList[arg_10_1]
end

function var_0_0.getOpenGroupShowInEpisode(arg_11_0, arg_11_1)
	return arg_11_0._openGroupShowInEpisodeList[arg_11_1]
end

function var_0_0.getOpensCO(arg_12_0)
	return arg_12_0._openConfig.configDict
end

function var_0_0.getOpenCo(arg_13_0, arg_13_1)
	return arg_13_0._openConfig.configDict[arg_13_1]
end

function var_0_0.getOpenGroupsCo(arg_14_0)
	return arg_14_0._opengroupConfig.configDict
end

function var_0_0.getOpenGroupCO(arg_15_0, arg_15_1)
	return arg_15_0._opengroupConfig.configDict[arg_15_1]
end

function var_0_0.isShowWaterMarkConfig(arg_16_0)
	if not arg_16_0.isShowWaterMark then
		arg_16_0.isShowWaterMark = SLFramework.GameConfig.Instance.ShowWaterMark
	end

	return arg_16_0.isShowWaterMark
end

var_0_0.instance = var_0_0.New()

return var_0_0
