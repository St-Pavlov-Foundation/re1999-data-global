module("modules.logic.bossrush.model.v1a6.V1a6_BossRush_BonusModel", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusModel", BaseModel)

function var_0_0.selecAchievementTab(arg_1_0, arg_1_1)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setAchievementMoList(arg_1_1)
end

function var_0_0.selectScheduleTab(arg_2_0, arg_2_1)
	V1a4_BossRush_ScheduleViewListModel.instance:setScheduleMoList(arg_2_1)
end

function var_0_0.selectSpecialScheduleTab(arg_3_0, arg_3_1)
	V2a1_BossRush_SpecialScheduleViewListModel.instance:setMoList(arg_3_1)
end

function var_0_0.getScheduleRewardData(arg_4_0, arg_4_1)
	local var_4_0 = BossRushModel.instance:getScheduleViewRewardList(arg_4_1)

	if var_4_0 then
		local var_4_1 = #var_4_0
		local var_4_2 = BossRushModel.instance:getLastPointInfo(arg_4_1)
		local var_4_3 = var_4_2 and var_4_2.cur or 0
		local var_4_4 = {
			dataCount = var_4_1,
			curNum = var_4_3
		}

		if var_4_3 == 0 then
			var_4_4.lastIndex = 0
			var_4_4.nextIndex = 1
		elseif var_4_3 >= var_4_2.max then
			var_4_4.lastIndex = var_4_1
			var_4_4.nextIndex = var_4_1
		else
			for iter_4_0, iter_4_1 in pairs(var_4_0) do
				local var_4_5 = iter_4_1.stageRewardCO.rewardPointNum

				if var_4_3 <= var_4_5 then
					var_4_4.lastIndex = var_4_3 == var_4_5 and iter_4_0 or iter_4_0 - 1
					var_4_4.nextIndex = iter_4_0

					break
				end
			end
		end

		var_4_4.lastIndex = var_4_4.lastIndex or 0
		var_4_4.nextIndex = var_4_4.nextIndex or 1
		var_4_4.lastNum = var_4_0[var_4_4.lastIndex] and var_4_0[var_4_4.lastIndex].stageRewardCO.rewardPointNum or 0
		var_4_4.nextNum = var_4_0[var_4_4.nextIndex] and var_4_0[var_4_4.nextIndex].stageRewardCO.rewardPointNum or 0

		return var_4_4
	end
end

function var_0_0.getScheduleProgressWidth(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:getScheduleRewardData(arg_5_1)
	local var_5_1
	local var_5_2

	if var_5_0 then
		var_5_1 = (var_5_0.dataCount - 1) * arg_5_2 + arg_5_3

		if var_5_0.lastIndex and var_5_0.nextIndex then
			if var_5_0.lastIndex == var_5_0.nextIndex then
				var_5_2 = var_5_0.lastIndex > 1 and (var_5_0.lastIndex - 1) * arg_5_2 + arg_5_3 or arg_5_3
			else
				local var_5_3 = (var_5_0.curNum - var_5_0.lastNum) / (var_5_0.nextNum - var_5_0.lastNum)

				var_5_2 = var_5_0.lastIndex > 0 and (var_5_0.lastIndex - 1 + var_5_3) * arg_5_2 + arg_5_3 or var_5_3 * arg_5_3
			end
		end
	end

	return var_5_1, var_5_2
end

function var_0_0.getLayer4RewardData(arg_6_0, arg_6_1)
	local var_6_0 = BossRushModel.instance:getSpecialScheduleViewRewardList(arg_6_1)

	if var_6_0 then
		local var_6_1 = #var_6_0
		local var_6_2 = BossRushModel.instance:getLayer4CurScore(arg_6_1)
		local var_6_3 = BossRushModel.instance:getLayer4MaxRewardScore(arg_6_1)
		local var_6_4 = {
			dataCount = var_6_1,
			curNum = var_6_2
		}

		if var_6_2 == 0 then
			var_6_4.lastIndex = 0
			var_6_4.nextIndex = 1
		elseif var_6_3 <= var_6_2 then
			var_6_4.lastIndex = var_6_1
			var_6_4.nextIndex = var_6_1
		else
			for iter_6_0, iter_6_1 in pairs(var_6_0) do
				local var_6_5 = iter_6_1.config.maxProgress

				if var_6_2 <= var_6_5 then
					var_6_4.lastIndex = var_6_2 == var_6_5 and iter_6_0 or iter_6_0 - 1
					var_6_4.nextIndex = iter_6_0

					break
				end
			end
		end

		var_6_4.lastIndex = var_6_4.lastIndex or 0
		var_6_4.nextIndex = var_6_4.nextIndex or 1
		var_6_4.lastNum = var_6_0[var_6_4.lastIndex] and var_6_0[var_6_4.lastIndex].config.maxProgress or 0
		var_6_4.nextNum = var_6_0[var_6_4.nextIndex] and var_6_0[var_6_4.nextIndex].config.maxProgress or 0

		return var_6_4
	end
end

function var_0_0.getLayer4ProgressWidth(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getLayer4RewardData(arg_7_1)
	local var_7_1
	local var_7_2

	if var_7_0 then
		var_7_1 = (var_7_0.dataCount - 1) * arg_7_2 + arg_7_3

		if var_7_0.lastIndex and var_7_0.nextIndex then
			if var_7_0.lastIndex == var_7_0.nextIndex then
				var_7_2 = var_7_0.lastIndex > 1 and (var_7_0.lastIndex - 1) * arg_7_2 + arg_7_3 or arg_7_3
			else
				local var_7_3 = (var_7_0.curNum - var_7_0.lastNum) / (var_7_0.nextNum - var_7_0.lastNum)

				var_7_2 = var_7_0.lastIndex > 0 and (var_7_0.lastIndex - 1 + var_7_3) * arg_7_2 + arg_7_3 or var_7_3 * arg_7_3
			end
		end
	end

	return var_7_1, var_7_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
