module("modules.logic.seasonver.act123.utils.Season123ProgressUtils", package.seeall)

local var_0_0 = class("Season123ProgressUtils")

function var_0_0.isStageUnlock(arg_1_0, arg_1_1)
	if not Season123Model.instance:getActInfo(arg_1_0) then
		return false
	end

	local var_1_0 = Season123Config.instance:getStageCo(arg_1_0, arg_1_1)

	if not var_1_0 then
		return false
	end

	local var_1_1 = GameUtil.splitString2(var_1_0.preCondition, true, "|", "#")

	if not var_1_1 then
		return true
	else
		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_2, var_1_3, var_1_4 = var_0_0.isConditionPass(arg_1_0, iter_1_1, arg_1_1)

			if not var_1_2 then
				return false, var_1_3, var_1_4
			end
		end

		return true
	end
end

function var_0_0.isConditionPass(arg_2_0, arg_2_1, arg_2_2)
	if #arg_2_1 <= 1 then
		return true
	end

	local var_2_0 = arg_2_1[1]

	if var_2_0 == Activity123Enum.PreCondition.StagePass then
		local var_2_1 = Season123Model.instance:getActInfo(arg_2_0)

		if not var_2_1 then
			return false
		end

		if not var_2_1:getStageMO(arg_2_2) then
			return false, Activity123Enum.PreCondition.StagePass
		end
	elseif var_2_0 == Activity123Enum.PreCondition.OpenTime then
		local var_2_2 = ActivityModel.instance:getActMO(arg_2_0):getRealStartTimeStamp()

		if var_2_2 ~= 0 then
			local var_2_3 = ServerTime.now() - var_2_2
			local var_2_4 = math.ceil(var_2_3 / TimeUtil.OneDaySecond)
			local var_2_5 = tonumber(arg_2_1[2])
			local var_2_6 = math.max(0, (var_2_5 - 1) * TimeUtil.OneDaySecond - var_2_3)

			return var_2_5 ~= nil and var_2_5 <= var_2_4, Activity123Enum.PreCondition.OpenTime, {
				day = var_2_5 - var_2_4,
				remainTime = var_2_6,
				showSec = var_2_6 < TimeUtil.OneDaySecond
			}
		end
	end

	return true
end

function var_0_0.getStageProgressStep(arg_3_0, arg_3_1)
	local var_3_0 = Season123Model.instance:getActInfo(arg_3_0)

	if not var_3_0 then
		return 0, 0
	end

	if not var_3_0:getStageMO(arg_3_1) then
		return 0, 0
	end

	return var_3_0:getStageRewardCount(arg_3_1)
end

function var_0_0.stageInChallenge(arg_4_0, arg_4_1)
	local var_4_0 = Season123Model.instance:getActInfo(arg_4_0)

	if not var_4_0 then
		return false
	end

	return var_4_0.stage == arg_4_1 and not var_0_0.checkStageIsFinish(arg_4_0, arg_4_1)
end

function var_0_0.checkStageIsFinish(arg_5_0, arg_5_1)
	local var_5_0 = Season123Model.instance:getActInfo(arg_5_0):getStageMO(arg_5_1)
	local var_5_1 = Season123Config.instance:getSeasonEpisodeByStage(arg_5_0, arg_5_1)

	if var_5_0 and var_5_1 and #var_5_1 > 0 then
		local var_5_2 = var_5_1[#var_5_1]
		local var_5_3 = var_5_0.episodeMap[var_5_2.layer]

		if var_5_3 then
			return var_5_3:isFinished()
		end
	end

	return false
end

function var_0_0.getMaxLayer(arg_6_0, arg_6_1)
	local var_6_0 = Season123Config.instance:getSeasonEpisodeStageCos(arg_6_0, arg_6_1)

	if not var_6_0 then
		return 0
	end

	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if var_6_1 < iter_6_1.layer then
			var_6_1 = iter_6_1.layer
		end
	end

	return var_6_1
end

function var_0_0.getEmptyLayerName(arg_7_0, arg_7_1)
	return string.format("v1a7_season_img_pic_empty_%s", arg_7_0)
end

function var_0_0.getResultBg(arg_8_0, arg_8_1)
	local var_8_0 = "singlebg/%s_season_singlebg/level/%s.png"

	return Season123ViewHelper.getIconUrl(var_8_0, arg_8_0, arg_8_1)
end

return var_0_0
