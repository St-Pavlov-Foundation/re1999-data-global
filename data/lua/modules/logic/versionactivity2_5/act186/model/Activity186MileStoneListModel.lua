module("modules.logic.versionactivity2_5.act186.model.Activity186MileStoneListModel", package.seeall)

local var_0_0 = class("Activity186MileStoneListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actMo = arg_1_1
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = Activity186Config.instance:getMileStoneList(arg_2_0.actMo.id)
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = {
			id = iter_2_1.rewardId,
			rewardId = iter_2_1.rewardId,
			activityId = iter_2_1.activityId,
			isLoopBonus = iter_2_1.isLoopBonus,
			bonus = iter_2_1.bonus,
			isSpBonus = iter_2_1.isSpBonus
		}

		table.insert(var_2_1, var_2_2)
	end

	arg_2_0:setList(var_2_1)
end

function var_0_0.caleProgressIndex(arg_3_0)
	local var_3_0 = Activity186Config.instance:getMileStoneList(arg_3_0.actMo.id)
	local var_3_1 = 0
	local var_3_2 = Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)
	local var_3_3 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_3_2)
	local var_3_4 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_5 = iter_3_1.coinNum

		if var_3_3 < var_3_5 then
			var_3_1 = iter_3_0 + (var_3_3 - var_3_4) / (var_3_5 - var_3_4) - 1

			return var_3_1
		end

		var_3_4 = var_3_5
	end

	local var_3_6 = #var_3_0
	local var_3_7

	var_3_7 = var_3_0[var_3_6 - 1] and var_3_0[var_3_6 - 1].coinNum or 0

	local var_3_8 = var_3_0[var_3_6]
	local var_3_9 = arg_3_0.actMo.getMilestoneProgress
	local var_3_10 = var_3_8.loopBonusIntervalNum or 1
	local var_3_11 = var_3_8.coinNum

	if var_3_9 < var_3_11 then
		var_3_1 = var_3_6
	else
		local var_3_12 = (var_3_3 - var_3_11) / var_3_10
		local var_3_13 = math.floor(var_3_12)

		if var_3_13 > math.floor((var_3_9 - var_3_11) / var_3_10) then
			var_3_1 = var_3_6
		else
			var_3_1 = var_3_6 - 1 + var_3_12 - var_3_13
		end
	end

	return var_3_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
