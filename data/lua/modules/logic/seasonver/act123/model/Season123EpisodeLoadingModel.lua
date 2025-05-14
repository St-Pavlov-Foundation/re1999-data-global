module("modules.logic.seasonver.act123.model.Season123EpisodeLoadingModel", package.seeall)

local var_0_0 = class("Season123EpisodeLoadingModel", BaseModel)

function var_0_0.release(arg_1_0)
	arg_1_0.activityId = nil
	arg_1_0.stage = nil
	arg_1_0.layer = nil
	arg_1_0._layerDict = nil

	arg_1_0:clear()
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2
	arg_2_0.layer = arg_2_3
	arg_2_0._layerDict = {}

	arg_2_0:initEpisodeList()
end

var_0_0.AnimCount = 7
var_0_0.EmptyStyleCount = 3
var_0_0.TargetEpisodeOrder = 5

function var_0_0.initEpisodeList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = Season123Config.instance:getSeasonEpisodeByStage(arg_3_0.activityId, arg_3_0.stage)

	logNormal("episode list length : " .. tostring(#var_3_1))

	local var_3_2 = Season123Model.instance:getActInfo(arg_3_0.activityId):getStageMO(arg_3_0.stage)

	if var_3_2 then
		local var_3_3 = #var_3_1

		for iter_3_0 = 1, var_0_0.AnimCount do
			local var_3_4 = (arg_3_0.layer - var_0_0.TargetEpisodeOrder + iter_3_0) % (var_3_3 + 1)
			local var_3_5 = Season123EpisodeLoadingMO.New()

			if var_3_4 == 0 then
				var_3_5:init(iter_3_0, nil, nil, 1)
			else
				local var_3_6 = var_3_1[var_3_4]
				local var_3_7 = var_3_2.episodeMap[var_3_6.layer]

				var_3_5:init(iter_3_0, var_3_7, var_3_6)

				if not arg_3_0._layerDict[var_3_6.layer] then
					arg_3_0._layerDict[var_3_6.layer] = var_3_5
				end
			end

			table.insert(var_3_0, var_3_5)
		end
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0.isEpisodeUnlock(arg_4_0, arg_4_1)
	local var_4_0 = Season123Model.instance:getActInfo(arg_4_0.activityId)
	local var_4_1 = arg_4_0._layerDict[arg_4_1]

	if var_4_1 and var_4_1.isFinished then
		return true
	end

	if arg_4_1 <= 1 then
		if not var_4_0 then
			return false
		end

		return arg_4_0.stage == var_4_0.stage
	end

	local var_4_2 = arg_4_0._layerDict[arg_4_1 - 1]

	if not var_4_2 or not var_4_2.isFinished then
		return false
	end

	return true
end

function var_0_0.inCurrentStage(arg_5_0)
	local var_5_0 = Season123Model.instance:getActInfo(arg_5_0.activityId)

	return var_5_0 ~= nil and not var_5_0:isNotInStage() and var_5_0.stage == var_0_0.instance.stage
end

var_0_0.instance = var_0_0.New()

return var_0_0
