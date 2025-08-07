module("modules.logic.bossrush.model.V1a4_BossRush_ScheduleViewListModel", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScheduleViewListModel", ListScrollModel)

function var_0_0.setStaticData(arg_1_0, arg_1_1)
	arg_1_0._staticData = arg_1_1
end

function var_0_0.getStaticData(arg_2_0)
	return arg_2_0._staticData
end

function var_0_0.getFinishCount(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if not iter_3_1.isGot and iter_3_1.isAlready then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_0.setScheduleMoList(arg_4_0, arg_4_1)
	local var_4_0 = BossRushModel.instance:getScheduleViewRewardList(arg_4_1)
	local var_4_1 = BossRushModel.instance:getLastPointInfo(arg_4_1)
	local var_4_2 = var_4_1 and var_4_1.cur or 0

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		iter_4_1.isAlready = var_4_2 >= iter_4_1.stageRewardCO.rewardPointNum
		iter_4_1.stage = arg_4_1
	end

	if arg_4_0:getFinishCount(var_4_0, arg_4_1) > 1 then
		table.insert(var_4_0, 1, {
			getAll = true,
			stage = arg_4_1
		})
	end

	table.sort(var_4_0, arg_4_0._sort)
	arg_4_0:setList(var_4_0)
end

function var_0_0._sort(arg_5_0, arg_5_1)
	if arg_5_0.getAll then
		return true
	end

	if arg_5_1.getAll then
		return false
	end

	local var_5_0 = arg_5_0.stageRewardCO
	local var_5_1 = arg_5_1.stageRewardCO
	local var_5_2 = var_5_0.id
	local var_5_3 = var_5_0.id
	local var_5_4 = arg_5_0.isGot and 1 or 0
	local var_5_5 = arg_5_1.isGot and 1 or 0
	local var_5_6 = arg_5_0.isAlready and 1 or 0
	local var_5_7 = arg_5_1.isAlready and 1 or 0
	local var_5_8 = var_5_0.rewardPointNum
	local var_5_9 = var_5_1.rewardPointNum

	if var_5_4 ~= var_5_5 then
		return var_5_4 < var_5_5
	end

	if var_5_6 ~= var_5_7 then
		return var_5_7 < var_5_6
	end

	if var_5_8 ~= var_5_9 then
		return var_5_8 < var_5_9
	end

	return var_5_2 < var_5_3
end

function var_0_0.isReddot(arg_6_0, arg_6_1)
	local var_6_0 = BossRushModel.instance:getScheduleViewRewardList(arg_6_1)
	local var_6_1 = BossRushModel.instance:getLastPointInfo(arg_6_1)
	local var_6_2 = var_6_1 and var_6_1.cur or 0

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_3 = var_6_2 >= iter_6_1.stageRewardCO.rewardPointNum
		local var_6_4 = BossRushModel.instance:hasGetBonusIds(arg_6_1, iter_6_1.id)

		if not iter_6_1.isGot and var_6_3 then
			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
