module("modules.logic.seasonver.act166.model.Season166BaseSpotModel", package.seeall)

local var_0_0 = class("Season166BaseSpotModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:cleanData()
end

function var_0_0.cleanData(arg_3_0)
	arg_3_0.curBaseSpotId = nil
	arg_3_0.curBaseSpotConfig = nil
	arg_3_0.curEpisodeId = nil
	arg_3_0.talentId = nil
end

function var_0_0.initBaseSpotData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.actId = arg_4_1
	arg_4_0.curBaseSpotId = arg_4_2
	arg_4_0.curBaseSpotConfig = Season166Config.instance:getSeasonBaseSpotCo(arg_4_1, arg_4_2)
	arg_4_0.curEpisodeId = arg_4_0.curBaseSpotConfig and arg_4_0.curBaseSpotConfig.episodeId
	arg_4_0.talentId = arg_4_0.curBaseSpotConfig and arg_4_0.curBaseSpotConfig.talentId
end

function var_0_0.getBaseSpotMaxScore(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Season166Model.instance:getActInfo(arg_5_1).baseSpotInfoMap[arg_5_2]

	if var_5_0 then
		return var_5_0.maxScore
	end

	return 0
end

function var_0_0.getStarCount(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_3 or arg_6_0:getBaseSpotMaxScore(arg_6_1, arg_6_2)
	local var_6_1 = Season166Config.instance:getSeasonScoreCos(arg_6_1)
	local var_6_2 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if var_6_0 >= iter_6_1.needScore then
			var_6_2 = iter_6_1.star
		end
	end

	return var_6_2
end

function var_0_0.getScoreLevelCfg(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3 or arg_7_0:getBaseSpotMaxScore(arg_7_1, arg_7_2)
	local var_7_1 = Season166Config.instance:getSeasonScoreCos(arg_7_1)

	for iter_7_0 = #var_7_1, 1, -1 do
		local var_7_2 = var_7_1[iter_7_0]

		if var_7_0 >= var_7_2.needScore then
			return var_7_2
		end
	end
end

function var_0_0.getCurTotalStarCount(arg_8_0, arg_8_1)
	local var_8_0 = 0
	local var_8_1 = Season166Config.instance:getSeasonBaseSpotCos(arg_8_1)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		var_8_0 = var_8_0 + arg_8_0:getStarCount(arg_8_1, iter_8_1.baseId)
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
