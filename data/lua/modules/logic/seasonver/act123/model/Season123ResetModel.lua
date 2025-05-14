module("modules.logic.seasonver.act123.model.Season123ResetModel", package.seeall)

local var_0_0 = class("Season123ResetModel", BaseModel)

var_0_0.EmptySelect = -1

function var_0_0.release(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2

	arg_2_0:initEpisodeList()
	arg_2_0:initDefaultSelected(arg_2_3)
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

	if arg_4_0:getById(arg_4_1).isFinished then
		return true
	end

	if arg_4_1 <= 1 then
		if not var_4_0 then
			return false
		end

		return arg_4_0.stage == var_4_0.stage
	end

	local var_4_1 = arg_4_0:getById(arg_4_1 - 1)

	if not var_4_1 or not var_4_1.isFinished then
		return false
	end

	return true
end

function var_0_0.initDefaultSelected(arg_5_0, arg_5_1)
	arg_5_0.layer = arg_5_1

	arg_5_0:updateHeroList()
end

function var_0_0.getCurrentChallengeLayer(arg_6_0)
	local var_6_0 = arg_6_0:getList()

	if not var_6_0 or #var_6_0 <= 0 then
		return 0
	end

	for iter_6_0 = 1, #var_6_0 do
		if not var_6_0[iter_6_0].isFinished then
			return iter_6_0
		end
	end

	return var_6_0[#var_6_0].cfg.layer
end

function var_0_0.getStageCO(arg_7_0)
	return Season123Config.instance:getStageCo(arg_7_0.activityId, arg_7_0.stage)
end

function var_0_0.getSelectLayerCO(arg_8_0)
	if arg_8_0.layer then
		return Season123Config.instance:getSeasonEpisodeCo(arg_8_0.activityId, arg_8_0.stage, arg_8_0.layer)
	end
end

function var_0_0.updateHeroList(arg_9_0)
	arg_9_0._showHeroMOList = {}

	if arg_9_0.layer == var_0_0.EmptySelect then
		return
	end

	local var_9_0 = Season123Model.instance:getActInfo(arg_9_0.activityId)

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0:getStageMO(arg_9_0.stage)

	if not var_9_1 then
		return
	end

	local var_9_2 = arg_9_0.layer or arg_9_0:getCurrentChallengeLayer()

	if var_9_2 then
		local var_9_3 = var_9_1.episodeMap[var_9_2]

		if not var_9_3 then
			return
		end

		local var_9_4 = var_9_3.heroes

		for iter_9_0, iter_9_1 in ipairs(var_9_4) do
			local var_9_5 = HeroModel.instance:getById(iter_9_1.heroUid)

			if not var_9_5 then
				local var_9_6, var_9_7 = Season123Model.instance:getAssistData(arg_9_0.activityId, arg_9_0.stage)

				if var_9_7 and var_9_7.heroUid == iter_9_1.heroUid then
					local var_9_8 = Season123ShowHeroMO.New()

					var_9_8:init(var_9_6, var_9_7.heroUid, var_9_7.heroId, var_9_7.skin, iter_9_1.hpRate, true)
					table.insert(arg_9_0._showHeroMOList, var_9_8)
				end
			else
				local var_9_9 = Season123ShowHeroMO.New()

				var_9_9:init(var_9_5, var_9_5.uid, var_9_5.heroId, var_9_5.skin, iter_9_1.hpRate, false)
				table.insert(arg_9_0._showHeroMOList, var_9_9)
			end
		end
	end
end

function var_0_0.getHeroList(arg_10_0)
	return arg_10_0._showHeroMOList
end

var_0_0.instance = var_0_0.New()

return var_0_0
