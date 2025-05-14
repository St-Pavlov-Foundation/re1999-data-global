module("modules.logic.versionactivity2_5.liangyue.model.LiangYueModel", package.seeall)

local var_0_0 = class("LiangYueModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._actInfoDic = {}
	arg_1_0._afterGameEpisodeDic = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfoDic = {}
end

function var_0_0.onGetActInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activityId
	local var_3_1

	if not arg_3_0._actInfoDic[var_3_0] then
		var_3_1 = {}
		arg_3_0._actInfoDic[var_3_0] = var_3_1
	else
		var_3_1 = arg_3_0._actInfoDic[var_3_0]

		tabletool.clear(var_3_1)
	end

	local var_3_2 = arg_3_1.episodes

	if not var_3_2 or #var_3_2 <= 0 then
		return
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		local var_3_3

		if LiangYueConfig.instance:getEpisodeConfigByActAndId(var_3_0, iter_3_1.episodeId) == nil then
			logError("episodeConfig not exist id: " .. iter_3_1.episodeId)
		elseif var_3_1[iter_3_1.episodeId] then
			logError("episodeId has exist id: " .. iter_3_1.episodeId)
		else
			local var_3_4 = LiangYueInfoMo.New()

			var_3_4:init(var_3_0, iter_3_1.episodeId, iter_3_1.isFinished, iter_3_1.puzzle)

			var_3_1[iter_3_1.episodeId] = var_3_4
		end
	end
end

function var_0_0.onActInfoPush(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activityId
	local var_4_1

	if not arg_4_0._actInfoDic[var_4_0] then
		var_4_1 = {}
		arg_4_0._actInfoDic[var_4_0] = var_4_1
	else
		var_4_1 = arg_4_0._actInfoDic[var_4_0]
	end

	local var_4_2 = arg_4_1.episodes

	if not var_4_2 or #var_4_2 <= 0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		local var_4_3

		if var_4_1[iter_4_1.episodeId] then
			var_4_1[iter_4_1.episodeId]:updateMO(iter_4_1.isFinished, iter_4_1.puzzle)
		else
			local var_4_4 = LiangYueInfoMo.New()

			var_4_4:init(var_4_0, iter_4_1.episodeId, iter_4_1.isFinished, iter_4_1.puzzle)

			var_4_1[iter_4_1.episodeId] = var_4_4
		end
	end
end

function var_0_0.getEpisodeInfoMo(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._actInfoDic[arg_5_1] then
		return nil
	end

	return arg_5_0._actInfoDic[arg_5_1][arg_5_2]
end

function var_0_0.getActInfoDic(arg_6_0, arg_6_1)
	return arg_6_0._actInfoDic[arg_6_1]
end

function var_0_0.setEpisodeInfo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getActInfoDic(arg_7_1.activityId)

	if var_7_0 == nil then
		return
	end

	local var_7_1 = var_7_0[arg_7_1.episodeId]

	if not var_7_1 then
		var_7_1 = LiangYueInfoMo.New()

		var_7_1:init(arg_7_1.activityId, arg_7_1.episodeId, true, arg_7_1.puzzle)

		return
	end

	var_7_1:updateMO(true, arg_7_1.puzzle)
end

function var_0_0.isEpisodeFinish(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getEpisodeInfoMo(arg_8_1, arg_8_2)

	if not var_8_0 then
		return false
	end

	return var_8_0.isFinish
end

function var_0_0.setCurEpisodeId(arg_9_0, arg_9_1)
	arg_9_0._curEpisodeId = arg_9_1
end

function var_0_0.getCurEpisodeId(arg_10_0)
	return arg_10_0._curEpisodeId
end

function var_0_0.setCurActId(arg_11_0, arg_11_1)
	arg_11_0._curActId = arg_11_1
end

function var_0_0.getCurActId(arg_12_0)
	return arg_12_0._curActId
end

var_0_0.instance = var_0_0.New()

return var_0_0
