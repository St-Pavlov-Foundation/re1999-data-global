module("modules.logic.seasonver.act123.model.Season123EpisodeDetailModel", package.seeall)

local var_0_0 = class("Season123EpisodeDetailModel", BaseModel)

function var_0_0.release(arg_1_0)
	arg_1_0.activityId = nil
	arg_1_0.stage = nil
	arg_1_0.layer = nil
	arg_1_0.lastSendEpisodeCfg = nil

	arg_1_0:clear()
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2
	arg_2_0.layer = arg_2_3
	arg_2_0.animRecord = Season123LayerLocalRecord.New()

	arg_2_0.animRecord:init(arg_2_0.activityId)
	arg_2_0:initEpisodeList()
end

function var_0_0.initEpisodeList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = Season123Config.instance:getSeasonEpisodeByStage(arg_3_0.activityId, arg_3_0.stage)

	logNormal("episode list length : " .. tostring(#var_3_1))

	local var_3_2 = Season123Model.instance:getActInfo(arg_3_0.activityId):getStageMO(arg_3_0.stage)

	if var_3_2 then
		for iter_3_0 = 1, #var_3_1 do
			local var_3_3 = var_3_1[iter_3_0]
			local var_3_4 = var_3_2.episodeMap[var_3_3.layer]
			local var_3_5 = Season123EpisodeListMO.New()

			var_3_5:init(var_3_4, var_3_3)
			table.insert(var_3_0, var_3_5)
		end
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0.isEpisodeUnlock(arg_4_0, arg_4_1)
	local var_4_0 = Season123Model.instance:getActInfo(arg_4_0.activityId)
	local var_4_1 = arg_4_0:getById(arg_4_1)

	if not var_4_1 then
		return false
	end

	if var_4_1.isFinished then
		return true
	end

	if arg_4_1 <= 1 then
		if not var_4_0 then
			return false
		end

		return arg_4_0.stage == var_4_0.stage
	end

	local var_4_2 = arg_4_0:getById(arg_4_1 - 1)

	if not var_4_2 or not var_4_2.isFinished then
		return false
	end

	return true
end

function var_0_0.setMakertLayerAnim(arg_5_0, arg_5_1)
	return arg_5_0.animRecord:add(arg_5_0.stage, arg_5_1)
end

function var_0_0.isNeedPlayMakertLayerAnim(arg_6_0, arg_6_1)
	return arg_6_0.animRecord:contain(arg_6_0.stage, arg_6_1)
end

function var_0_0.getCurrentChallengeLayer(arg_7_0)
	local var_7_0 = arg_7_0:getList()

	if not var_7_0 or #var_7_0 <= 0 then
		return 0
	end

	for iter_7_0 = 1, #var_7_0 do
		if not var_7_0[iter_7_0].isFinished then
			return iter_7_0
		end
	end

	return var_7_0[#var_7_0].cfg.layer
end

function var_0_0.isNextLayerNewStarGroup(arg_8_0, arg_8_1)
	local var_8_0 = Season123Config.instance:getSeasonEpisodeCo(arg_8_0.activityId, arg_8_1)
	local var_8_1 = var_8_0 and var_8_0.starGroup or 0
	local var_8_2 = Season123Config.instance:getSeasonEpisodeCo(arg_8_0.activityId, arg_8_1 + 1)

	if not var_8_2 then
		return false
	end

	local var_8_3 = var_8_2.starGroup

	return var_8_1 ~= nil and var_8_1 ~= var_8_3
end

function var_0_0.alreadyPassEpisode(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getById(arg_9_1)

	if not var_9_0 then
		return false
	end

	local var_9_1 = Season123Config.instance:getSeasonEpisodeCo(arg_9_0.activityId, arg_9_0.stage, arg_9_1)

	if var_9_0.round <= 0 and var_9_1 then
		local var_9_2 = DungeonModel.instance:getEpisodeInfo(var_9_1.episodeId)

		if var_9_2 and var_9_2.star > 0 then
			return true
		end
	end

	return var_9_0.round > 0
end

function var_0_0.getCurStarGroup(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = Season123Config.instance:getSeasonEpisodeCo(arg_10_1, arg_10_0.stage, arg_10_2)

	return var_10_0 and var_10_0.group or 0
end

function var_0_0.getEpisodeCOListByStar(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = Season123Config.instance:getSeasonEpisodeByStage(arg_11_0.activityId, arg_11_0.stage)

	if var_11_1 then
		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			if not iter_11_1.starGroup or iter_11_1.starGroup == arg_11_1 then
				table.insert(var_11_0, iter_11_1)
			end
		end
	end

	return var_11_0
end

function var_0_0.getCurFinishRound(arg_12_0)
	local var_12_0 = Season123Model.instance:getActInfo(arg_12_0.activityId)

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0:getStageMO(arg_12_0.stage)

	if not var_12_1 then
		return
	end

	local var_12_2 = var_12_1.episodeMap[arg_12_0.layer]

	if not var_12_2 then
		return
	end

	return var_12_2.round
end

var_0_0.instance = var_0_0.New()

return var_0_0
